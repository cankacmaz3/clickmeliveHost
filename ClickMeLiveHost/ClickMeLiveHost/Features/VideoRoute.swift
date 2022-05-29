//
//  VideoRoute.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 29.05.2022.
//

import Foundation
import AVKit

protocol VideoRoute {
    func openVideoModule(url: URL)
}

extension VideoRoute where Self: RouterProtocol {
    func openVideoModule(url: URL) {
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        UIApplication.shared.windows.first?.rootViewController?.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
}
