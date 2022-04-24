//
//  BroadcastConfiguration.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 24.04.2022.
//

import AmazonIVSBroadcast

class BroadcastConfiguration {
    static let shared = BroadcastConfiguration()

    private var cameraSlotName: String { return "camera" }
    
    var activeConfiguration: IVSBroadcastConfiguration = IVSPresets.configurations().basicPortrait()
    var activeVideoConfiguration = IVSVideoConfiguration()
    
    init() {
        
        loadVideoConfiguration()
        setupSlots()
        activeConfiguration.video = activeVideoConfiguration
    }

    func setupSlots() {
        let cameraSlot = IVSMixerSlotConfiguration()
        do { try cameraSlot.setName(cameraSlotName) } catch {
            print("❌ Could not set camera slot name: \(error)")
        }
        cameraSlot.preferredAudioInput = .microphone
        cameraSlot.preferredVideoInput = .camera
        cameraSlot.matchCanvasAspectMode = false
        cameraSlot.aspect = .fill
        cameraSlot.zIndex = 0

        activeConfiguration.mixer.slots = [cameraSlot]
    }

    func loadVideoConfiguration() {
        do {
            try activeVideoConfiguration.setSize(CGSize(width: 480, height: 852))
            try activeVideoConfiguration.setMaxBitrate(1_500_000)
            try activeVideoConfiguration.setInitialBitrate(1_500_000)
            try activeVideoConfiguration.setMinBitrate(1_500_000)
            try activeVideoConfiguration.setTargetFramerate(30)
        } catch {
            print(error, "setting up session")
        }
    }
}

