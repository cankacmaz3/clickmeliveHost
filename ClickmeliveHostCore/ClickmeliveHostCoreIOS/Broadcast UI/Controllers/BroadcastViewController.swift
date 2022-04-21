//
//  BroadcastViewController.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 17.04.2022.
//

import UIKit
import AmazonIVSBroadcast

public final class BroadcastViewController: UIViewController, Layouting {
    public typealias ViewType = BroadcastView
    
    // State management
    private var isRunning = false {
        didSet {
            layoutableView.lblStreamStatus.text = isRunning ? "Stop" : "Start"
        }
    }
    
    private var isMuted = false {
        didSet {
            applyMute()
        }
    }
    
    private var attachedCamera: IVSDevice? {
        didSet {
            if let preview = try? (attachedCamera as? IVSImageDevice)?.previewView(with: .fill) {
                attachCameraPreview(container: layoutableView.previewView, preview: preview)
            } else {
                layoutableView.previewView.subviews.forEach { $0.removeFromSuperview() }
            }
        }
    }
    
    private var attachedMicrophone: IVSDevice? {
        didSet {
            // When a new microphone is attached it has a default gain of 1. This reapplies the mute setting
            // immediately after the new microphone is attached.
            applyMute()
        }
    }
    
    private var broadcastSession: IVSBroadcastSession?

    public override func viewDidLoad() {
        super.viewDidLoad()
        registerActions()
        isMuted = false // trigger didSet because Storyboards don't support iOS version checks.
    }
    
    public override func loadView() {
        view = ViewType.create()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // The SDK will not handle disabling the idle timer for you because that might
        // interfere with your application's use of this API elsewhere.
        UIApplication.shared.isIdleTimerDisabled = true

        checkAVPermissions { [weak self] granted in
            if granted {
                if self?.broadcastSession == nil {
                    self?.setupSession()
                }
            } else {
                //self?.displayPermissionError()
            }
        }
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UIApplication.shared.isIdleTimerDisabled = false
    }
    
    private func registerActions() {
        let streamGesture = UITapGestureRecognizer(target: self, action: #selector(streamStatusViewTapped))
        layoutableView.streamStatusView.addGestureRecognizer(streamGesture)
        
        let soundGesture = UITapGestureRecognizer(target: self, action: #selector(soundTapped))
        layoutableView.ivSound.addGestureRecognizer(soundGesture)
    }
    
    @objc private func soundTapped() {
        isMuted.toggle()
    }
    
    private func setupSession() {
        do {
            // Create the session with a preset config and camera/microphone combination.
            IVSBroadcastSession.applicationAudioSessionStrategy = .playAndRecord
            let broadcastSession = try IVSBroadcastSession(configuration: IVSPresets.configurations().standardPortrait(),
                                                           descriptors: IVSPresets.devices().frontCamera(),
                                                           delegate: self)
            broadcastSession.awaitDeviceChanges { [weak self] in
                let devices = broadcastSession.listAttachedDevices()
                let cameras = devices
                    .filter { $0.descriptor().type == .camera }
                    .compactMap { $0 as? IVSImageDevice }

                self?.attachedCamera = cameras.first
                self?.attachedMicrophone = devices.first(where: { $0.descriptor().type == .microphone })
            }
            self.broadcastSession = broadcastSession
        } catch {
            displayErrorAlert(error, "setting up session")
        }
    }
    
    private func setCamera(_ device: IVSDeviceDescriptor) {
        guard let broadcastSession = self.broadcastSession else { return }

        // either attach or exchange based on current state.
        if attachedCamera == nil {
            broadcastSession.attach(device, toSlotWithName: nil) { newDevice, _ in
                self.attachedCamera = newDevice
            }
        } else if let currentCamera = self.attachedCamera, currentCamera.descriptor().urn != device.urn {
            broadcastSession.exchangeOldDevice(currentCamera, withNewDevice: device) { newDevice, _ in
                self.attachedCamera = newDevice
            }
        }
    }
    
    func setMicrophone(_ device: IVSDeviceDescriptor) {
        guard let broadcastSession = self.broadcastSession else { return }

        // either attach or exchange based on current state.
        if attachedMicrophone == nil {
            broadcastSession.attach(device, toSlotWithName: nil) { newDevice, _ in
                self.attachedMicrophone = newDevice
            }
        } else if let currentMic = self.attachedMicrophone, currentMic.descriptor().urn != device.urn {
            broadcastSession.exchangeOldDevice(currentMic, withNewDevice: device) { newDevice, _ in
                self.attachedMicrophone = newDevice
            }
        }
    }
    
    private func refreshAttachedDevices() {
        guard let session = broadcastSession else { return }
        let attachedDevices = session.listAttachedDevices()
        let cameras = attachedDevices.filter { $0.descriptor().type == .camera }
        let microphones = attachedDevices.filter { $0.descriptor().type == .microphone }
        attachedCamera = cameras.first
        attachedMicrophone = microphones.first
    }
    
    @objc private func streamStatusViewTapped() {
        if isRunning {
            // Stop the session if we're running
            broadcastSession?.stop()
            isRunning = false
        } else {
            // Start the session if we're not running.
            let endpointPath = "rtmps://90844767ab44.global-contribute.live-video.net:443/app/"
            let url = URL(string: endpointPath)!
            let key = "sk_eu-west-1_SciUKyY92qfp_9ceAEiJ6dT21zvmYAhassoLeefjjWT"
            
            do {
                // store this endpoint/key pair to share with the screen capture extension
                // and to auto-complete the next time this app is launched
                let authItem = AuthItem(endpoint: endpointPath, streamKey: key)
                UserDefaultsAuthDao.shared.insert(authItem)
                try broadcastSession?.start(with: url, streamKey: key)
                isRunning = true
            } catch {
                displayErrorAlert(error, "starting session")
            }
        }
    }
    
    private func applyMute() {
        // It is important to note that when muting a microphone by adjusting the gain, the microphone will still be recording.
        // The orange light indicator on iOS devices will remain active. The SDK is still receiving all the real audio
        // samples, it is just applying a gain of 0 to them. To make the orange light turn off you need to detach the microphone
        // completely from the SDK, not just mute it.

        let gain: Float = isMuted ? 0 : 1
        let muteAll = true // toggle to change the mute strategy. Both are functionally equivalent in this sample app

        // In case there are any pending changes, let them finish and then update the mute status.
        broadcastSession?.awaitDeviceChanges { [weak self] in
            guard let `self` = self else { return }
            if (muteAll) {
                // This mutes all attached devices audio devices, doing so will mute all incoming audio until the gain
                // on one of the IVSAudioDevices is changed, or a new device is attached with a non-zero gain.
                self.broadcastSession?.listAttachedDevices()
                    .compactMap { $0 as? IVSAudioDevice }
                    .forEach { $0.setGain(gain) }
            } else {
                // This mutes just a single device
                (self.attachedMicrophone as? IVSAudioDevice)?.setGain(gain)
            }
        }

        layoutableView.handleSoundImage(isMuted: isMuted)
    }
    
    func attachCameraPreview(container: UIView, preview: UIView) {
        // Clear current view, and then attach the new view.
        container.subviews.forEach { $0.removeFromSuperview() }
        container.addSubview(preview)
        preview.fillSuperview()
    }
    
    func checkAVPermissions(_ result: @escaping (Bool) -> Void) {
        // Make sure we have both audio and video permissions before setting up the broadcast session.
        checkOrGetPermission(for: .video) { granted in
            guard granted else {
                result(false)
                return
            }
            self.checkOrGetPermission(for: .audio) { granted in
                guard granted else {
                    result(false)
                    return
                }
                result(true)
            }
        }
    }
    
    func checkOrGetPermission(for mediaType: AVMediaType, _ result: @escaping (Bool) -> Void) {
        func mainThreadResult(_ success: Bool) {
            DispatchQueue.main.async { result(success) }
        }
        switch AVCaptureDevice.authorizationStatus(for: mediaType) {
        case .authorized: mainThreadResult(true)
        case .notDetermined: AVCaptureDevice.requestAccess(for: mediaType) { mainThreadResult($0) }
        case .denied, .restricted: mainThreadResult(false)
        @unknown default: mainThreadResult(false)
        }
    }
}

extension BroadcastViewController : IVSBroadcastSession.Delegate {

    public func broadcastSession(_ session: IVSBroadcastSession, didChange state: IVSBroadcastSession.State) {
        print("IVSBroadcastSession state did change to \(state.rawValue)")
      /*  DispatchQueue.main.async {
            switch state {
            case .invalid: self.connectionView.backgroundColor = .darkGray
            case .connecting: self.connectionView.backgroundColor = .yellow
            case .connected: self.connectionView.backgroundColor = .green
            case .disconnected:
                self.connectionView.backgroundColor = .darkGray
                self.isRunning = false
            case .error:
                self.connectionView.backgroundColor = .red
                self.isRunning = false
            @unknown default: self.connectionView.backgroundColor = .darkGray
            }
        } */
    }

    public func broadcastSession(_ session: IVSBroadcastSession, didEmitError error: Error) {
        DispatchQueue.main.async {
           // self.displayErrorAlert(error, "in SDK")
        }
    }

    public func broadcastSession(_ session: IVSBroadcastSession, didAddDevice descriptor: IVSDeviceDescriptor) {
        print("IVSBroadcastSession did discover device \(descriptor)")
        // When audio routes change (like a Bluetooth headset turning off),
        // Apple will automatically switch the current route. Wait for the
        // IVS SDK to catch up and then refresh the current connected devices.
        session.awaitDeviceChanges {
         //   self.refreshAttachedDevices()
        }
    }

    public func broadcastSession(_ session: IVSBroadcastSession, didRemoveDevice descriptor: IVSDeviceDescriptor) {
        print("IVSBroadcastSession did lose device \(descriptor)")
        // Same comment as didAddDevice above.
        session.awaitDeviceChanges {
          //  self.refreshAttachedDevices()
        }
    }

    public func broadcastSession(_ session: IVSBroadcastSession, audioStatsUpdatedWithPeak peak: Double, rms: Double) {
        // This fires frequently, so we don't log it here.
    }

}

struct AuthItem: Codable {
    let endpoint: String
    let streamKey: String
}

/// A simple UserDefaults based storage class to store and recall previously used endpoint / stream key pairs.
class UserDefaultsAuthDao: UserDefaultsDao {
    
    static let shared = UserDefaultsAuthDao()
    
    private let UserDefaultsKey = "UserDefaultsAuthDaoKey"
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private var authItems = [AuthItem]()
    
    private override init() {
        super.init()
        if let data = userDefaults.data(forKey: UserDefaultsKey), let items = try? decoder.decode([AuthItem].self, from: data) {
            authItems = items
        }
    }
    
    func fetchAll() -> [AuthItem] {
        return authItems
    }

    func lastUsedAuth() -> AuthItem? {
        return fetchAll().last
    }
    
    func insert(_ authItem: AuthItem) {
        authItems.removeAll { $0.endpoint == authItem.endpoint }
        authItems.append(authItem)
        if let data = try? encoder.encode(authItems) {
            userDefaults.set(data, forKey: UserDefaultsKey)
        }
    }
}


class UserDefaultsDao {

    let userDefaults: UserDefaults

    init() {
        // This will need to be changed to your own app group. Otherwise
        // ScreenCapture (ReplayKit) won't be able to use credentials entered in the main app.
        // You can always hard code values in this demo though.
        guard let userDefaults = UserDefaults(suiteName: "group.com.example.amazon-samplecode.BasicBroadcast") else {
            fatalError("No access no shared user defaults")
        }
        self.userDefaults = userDefaults
    }

}

extension UIViewController {
    func displayPermissionError() {
        let alert = UIAlertController(title: "Permission Error",
                                      message: "This app does not have access to either the microphone or camera permissions. Please go into system settings and enable thees permissions for this app.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    func displayErrorAlert(_ error: Error, _ msg: String) {
        // Display the error if something went wrong.
        // This is mainly for debugging. Human-readable error descriptions are provided for
        // `IVSBroadcastError`s, but they may not be especially useful for the end user.
        let alert = UIAlertController(title: "Error \(msg) (Code: \((error as NSError).code))",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
