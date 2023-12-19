//
//  VideoView.swift
//  multiTaskApp
//
//  Created by asmaa gamal  on 15/12/2023.
import SwiftUI
import AVFoundation
import MobileCoreServices

struct VideoView: View {
    @State private var showPicker = false
    @State private var videoURL: URL?

    var body: some View {
        VStack {
            Button(action: {
                self.showPicker.toggle()
            }) {
                Text("Select or Record Video")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .sheet(isPresented: $showPicker) {
            VideoPickerView(sourceType: .camera, mediaTypes: [kUTTypeMovie as String], selectedVideo: self.$videoURL)
//            
            }
        
    }

 
}
