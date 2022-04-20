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
    
    // This broadcast session is the main interaction point with the SDK
    private var broadcastSession: IVSBroadcastSession?

    
    private var attachedCamera: IVSDevice? {
        didSet {
            layoutableView.lblStreamStatus.text = attachedCamera?.descriptor().friendlyName ?? "None"

            if let preview = try? (attachedCamera as? IVSImageDevice)?.previewView(with: .fill) {
                attachCameraPreview(container: layoutableView.previewView, preview: preview)
            } else {
                layoutableView.previewView.subviews.forEach { $0.removeFromSuperview() }
            }
        }
    }
    
    private var attachedMicrophone: IVSDevice? {
        didSet {
            //microphoneButton.setTitle(attachedMicrophone?.descriptor().friendlyName ?? "None", for: .normal)
            // When a new microphone is attached it has a default gain of 1. This reapplies the mute setting
            // immediately after the new microphone is attached.
            //applyMute()
        }
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
            //displayErrorAlert(error, "setting up session")
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
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
