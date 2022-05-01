//
//  LiveEventsVC+Broadcast.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 23.04.2022.
//

import AmazonIVSBroadcast
import UIKit

// MARK: - Broadcaster Lifecycle
extension BroadcastViewController {
    
    internal func setupBroadcastObservers() {
        observeIsRunning()
        observeTimeElapsed()
        observeMute()
        observeUpdateStatuses()
    }
    
    func broadcasterViewDidLoad() {
        broadcastViewModel.isMuted = false
    }
    
    func broadcasterViewDidAppear() {
        // The SDK will not handle disabling the idle timer for you because that might
        // interfere with your application's use of this API elsewhere.
        UIApplication.shared.isIdleTimerDisabled = true

        checkAVPermissions { [weak self] granted in
            if granted {
                if self?.broadcastSession == nil {
                    self?.setupSession()
                }
            } else {
                self?.displayPermissionError()
            }
        }
    }
    
    func broadcasterViewDidDisappear() {
        UIApplication.shared.isIdleTimerDisabled = false
    }
}

// MARK: - Broadcaster Observers
extension BroadcastViewController {
    private func observeIsRunning() {
        broadcastViewModel.isRunningValueChanged = { [weak self] isRunning in
            guard let self = self else { return }
            self.layoutableView.updateStreamStatus(broadcastViewModel: self.broadcastViewModel)
        }
    }
    
    private func observeMute() {
        broadcastViewModel.isMutedValueChanged = { [weak self] in
            self?.applyMute()
        }
    }
    
    private func observeTimeElapsed() {
        broadcastViewModel.timer.onTimeElapsed = { [weak self] time in
            self?.layoutableView.lblTimer.text = time
        }
    }
    
    private func observeUpdateStatuses() {
        broadcastViewModel.onStatusUpdatedToLive = { [weak self] event in
            guard let self = self else { return }
            let endpointPath = event.liveStream?.ingestEndpoint
            let key = event.liveStream?.streamKey
            
            guard let endpointPath = endpointPath, let key = key else { return }
            let url = URL(string: endpointPath)!
            
            do {
                try self.broadcastSession?.start(with: url, streamKey: key)
                self.broadcastViewModel.timer.start()
                self.broadcastViewModel.isRunning = true
            } catch {
                self.displayErrorAlert(error, "starting session")
            }
        }
        
        broadcastViewModel.onStatusUpdatedToEnded = { [weak self] in
            self?.showStopBroadcastAlert()
        }
    }
    
    private func showStopBroadcastAlert() {
        let alert = UIAlertController(title: nil,
                                      message: nil,
                                      preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Yayını Sonlandır", style: .destructive, handler: { [weak self] _ in
            // Stop the session if we're running
            self?.broadcastSession?.stop()
            self?.broadcastViewModel.timer.stop()
            self?.broadcastViewModel.isRunning = false
            self?.onClose?()
        }))
        
        alert.addAction(UIAlertAction(title: "Vazgeç", style: .cancel))
        present(alert, animated: true)
    }
}

// MARK: - Broadcaster Actions
extension BroadcastViewController {
    @objc func streamTapped() {
        if self.broadcastViewModel.isRunning {
            broadcastViewModel.updateStatus(eventId: eventId, with: .ENDED)
        } else {
            broadcastViewModel.updateStatus(eventId: eventId, with: .LIVE)
        }
    }
    
    @objc func cameraTapped() {
        guard let device = getCameraDescriptor(for: attachedCamera?.descriptor().position == .back ? .front : .back) else { return }
        setCamera(device)
    }
    
    @objc func muteTapped() {
        broadcastViewModel.isMuted.toggle()
    }
    
    @objc func closeTapped() {
        if self.broadcastViewModel.isRunning {
            showStopBroadcastAlert()
        } else {
            onClose?()
        }
    }
}

// MARK: - Broadcast Utility methods
extension BroadcastViewController {
    private func getCameraDescriptor(for position: IVSDevicePosition) -> IVSDeviceDescriptor? {
        let defaultCamera = IVSBroadcastSession.listAvailableDevices().first(where: { $0.urn == "default_camera" })

        if defaultCamera?.position == position {
            return defaultCamera
        } else {
            return IVSBroadcastSession.listAvailableDevices().last(where: { $0.type == .camera && $0.position == position })
        }
    }
    
    public func applyMute() {
        // It is important to note that when muting a microphone by adjusting the gain, the microphone will still be recording.
        // The orange light indicator on iOS devices will remain active. The SDK is still receiving all the real audio
        // samples, it is just applying a gain of 0 to them. To make the orange light turn off you need to detach the microphone
        // completely from the SDK, not just mute it.

        let gain: Float = broadcastViewModel.isMuted ? 0 : 1
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

        layoutableView.handleSoundImage(isMuted: broadcastViewModel.isMuted)
    }
    
    private func setupSession() {
        do {
            let config = BroadcastConfiguration.shared.activeConfiguration
            IVSBroadcastSession.applicationAudioSessionStrategy = .playAndRecord
            let broadcastSession = try IVSBroadcastSession(configuration: config,
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

    private func refreshAttachedDevices() {
        guard let session = broadcastSession else { return }
        let attachedDevices = session.listAttachedDevices()
        let cameras = attachedDevices.filter { $0.descriptor().type == .camera }
        let microphones = attachedDevices.filter { $0.descriptor().type == .microphone }
        attachedCamera = cameras.first
        attachedMicrophone = microphones.first
    }
}

// MARK: - IVS Broadcast SDK Delegate

extension BroadcastViewController : IVSBroadcastSession.Delegate {

    public func broadcastSession(_ session: IVSBroadcastSession, didChange state: IVSBroadcastSession.State) {
        print("IVSBroadcastSession state did change to \(state.rawValue)")
        DispatchQueue.main.async { [weak self] in
            switch state {
            case .connected:
                self?.layoutableView.viewersView.isHidden = false
            case .disconnected:
                self?.layoutableView.viewersView.isHidden = true
                self?.broadcastViewModel.isRunning = false
            case .error:
                self?.broadcastViewModel.isRunning = false
            default:
                break
            }
        }
    }

    public func broadcastSession(_ session: IVSBroadcastSession, didEmitError error: Error) {
        DispatchQueue.main.async {
            self.displayErrorAlert(error, "in SDK")
            self.broadcastViewModel.timer.stop()
        }
    }

    public func broadcastSession(_ session: IVSBroadcastSession, didAddDevice descriptor: IVSDeviceDescriptor) {
        print("IVSBroadcastSession did discover device \(descriptor)")
        // When audio routes change (like a Bluetooth headset turning off),
        // Apple will automatically switch the current route. Wait for the
        // IVS SDK to catch up and then refresh the current connected devices.
        session.awaitDeviceChanges {
            self.refreshAttachedDevices()
        }
    }

    public func broadcastSession(_ session: IVSBroadcastSession, didRemoveDevice descriptor: IVSDeviceDescriptor) {
        print("IVSBroadcastSession did lose device \(descriptor)")
        // Same comment as didAddDevice above.
        session.awaitDeviceChanges {
            self.refreshAttachedDevices()
        }
    }

    public func broadcastSession(_ session: IVSBroadcastSession, audioStatsUpdatedWithPeak peak: Double, rms: Double) {
        // This fires frequently, so we don't log it here.
    }

}
