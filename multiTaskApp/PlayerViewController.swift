//
//  PlayerViewController.swift
//  multiTaskApp
//
//  Created by asmaa gamal  on 16/12/2023.
//

import Foundation
import SwiftUI
import AVKit

struct PlayerViewController: UIViewControllerRepresentable {
    let player: AVPlayer

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        return playerViewController
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {}
}
