//
//  ShowAllAudioView.swift
//  multiTaskApp
//
//  Created by asmaa gamal  on 15/12/2023.
//

import SwiftUI
import AVKit
struct AVPlayerView: UIViewControllerRepresentable {
    let player: AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let playerController = AVPlayerViewController()
        playerController.player = player
        return playerController
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {}
}
struct ShowAllAudioView: View {
    @ObservedObject var documentDirectoryManger : DocumentDirectoryManager
    var audioManager = AudioManger()
    init(){
        documentDirectoryManger = DocumentDirectoryManager.shared
        audioManager = AudioManger.shared
        
    }
    var body: some View {
            NavigationView {
                List {
                    ForEach(documentDirectoryManger.audios, id: \.self) { audioUrl in
                        Button(action: {
                            let player = AVPlayer(url: audioUrl)
                            let playerView = AVPlayerView(player: player)
                            UIApplication.shared.windows.first?.rootViewController?.present(
                                UIHostingController(rootView: playerView),
                                animated: true,
                                completion: {
                                    player.play()
                                }
                            )
                        }) {
                            Text(audioUrl.lastPathComponent) // Display the filename in the list
                        }
                    }
                }
                .navigationBarTitle("All Audios")
            }
            .padding()
        }
    }

#Preview {
    ShowAllAudioView()
}
