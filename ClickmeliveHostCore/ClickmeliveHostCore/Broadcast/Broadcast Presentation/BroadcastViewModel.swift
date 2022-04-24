//
//  BroadcastViewModel.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 23.04.2022.
//

import Foundation

public final class BroadcastViewModel {
    public typealias Observer<T> = (T) -> Void
    
    public init() {}
    
    // MARK: - States
    public var isRunning: Bool = false {
        didSet {
            isRunningValueChanged?(isRunning)
        }
    }
    
    public var isMuted: Bool = false {
        didSet {
            isMutedValueChanged?()
        }
    }
    
    public var timer = ElapsedTimeAndDataManager()
    
    public var isRunningValueChanged: Observer<Bool>?
    public var isMutedValueChanged: (() -> Void)?
    
    public var streamStatus: String {
        isRunning ? Localized.Broadcast.stopBroadcast: Localized.Broadcast.startBroadcast
    }
}
