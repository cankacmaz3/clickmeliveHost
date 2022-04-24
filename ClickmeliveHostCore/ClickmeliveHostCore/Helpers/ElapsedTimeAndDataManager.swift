//
//  ElapsedTimeAndDataManager.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 24.04.2022.
//

import Foundation

public class ElapsedTimeAndDataManager {
   
    public var onTimeElapsed: ((String) -> Void)?
    
    private var isRunning: Bool = false
    private var timer = Timer()
    
    private var elapsed: Int = 0 {
        didSet {
            onTimeElapsed?(formatToTimeString(elapsed))
        }
    }
    
    public func start() {
        guard !isRunning else { return }
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            self?.elapsed += 1
        }
        isRunning = true
    }

    public func stop() {
        timer.invalidate()
        elapsed = 0
        isRunning = false
    }

    private func formatToTimeString(_ seconds: Int) -> String {
        let h: Int = seconds / 3600
        let m: Int = (seconds / 60) % 60
        let s: Int = seconds % 60
        
        var time = String(format: " %02u:%02u  ", m, s)
        if h > 0 {
            time = String(format: " %u:%02u:%02u  ", h, m, s)
        }
        return time
    }
}
