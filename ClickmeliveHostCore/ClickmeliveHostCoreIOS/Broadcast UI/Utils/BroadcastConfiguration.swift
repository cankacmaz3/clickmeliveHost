//
//  BroadcastConfiguration.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 24.04.2022.
//

import AmazonIVSBroadcast
import ClickmeliveHostCore

class BroadcastConfiguration {
    static let shared = BroadcastConfiguration(with: .SD)

    private var cameraSlotName: String { return "camera" }
    
    var activeConfiguration: IVSBroadcastConfiguration = IVSPresets.configurations().basicPortrait()
    var activeVideoConfiguration = IVSVideoConfiguration()
    
    init(with resolution: Event.LiveStream.Resolution?) {
        
        resolution == .HD ?
        loadHDVideoConfiguration():
        loadSDVideoConfiguration()
        
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

    func loadSDVideoConfiguration() {
        print("SD VİDEO CONFIG")
        do {
            try activeVideoConfiguration.setSize(CGSize(width: 480, height: 852))
            try activeVideoConfiguration.setMaxBitrate(1_500_000)
            try activeVideoConfiguration.setInitialBitrate(500_000)
            try activeVideoConfiguration.setMinBitrate(500_000)
            try activeVideoConfiguration.setTargetFramerate(30)
        } catch {
            print(error, "setting up session")
        }
    }
    
    func loadHDVideoConfiguration() {
        print("HD VİDEO CONFIG")
        do {
            try activeVideoConfiguration.setSize(CGSize(width: 720, height: 1280))
            try activeVideoConfiguration.setMaxBitrate(4_500_000)
            try activeVideoConfiguration.setInitialBitrate(1_500_000)
            try activeVideoConfiguration.setMinBitrate(1_500_000)
            try activeVideoConfiguration.setTargetFramerate(30)
        } catch {
            print(error, "setting up session")
        }
    }
}

