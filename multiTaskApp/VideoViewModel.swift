//
//  VideoViewModel.swift
//  multiTaskApp
//
//  Created by asmaa gamal  on 20/12/2023.
//

import Foundation

class VideoViewModel: ObservableObject {
    @Published var videoURLs: [URL] = []
    init(){
        fetchVideos()
    }
    func fetchVideos() {

        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            let contents = try FileManager.default.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil)
            
            let videoFiles = contents.filter { $0.pathExtension == "mp4" }
            
            videoURLs = videoFiles
        } catch {
            print("Error fetching videos: \(error)")
        }
    }
}
