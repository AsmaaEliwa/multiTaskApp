//
//  DisplayVideosView.swift
//  multiTaskApp
//
//  Created by asmaa gamal  on 20/12/2023.
//

import SwiftUI
import AVKit

struct DisplayVideosView: View {
    @ObservedObject var videoViewModel = VideoViewModel()
    
    var body: some View {
        List {
            ForEach(videoViewModel.videoURLs, id: \.self) { videoURL in
                
                VideoPlayer(player: AVPlayer(url: videoURL))
                    .frame(height: 200)
            }
        }
        .onAppear {
            videoViewModel.fetchVideos()
        }
    }
}
