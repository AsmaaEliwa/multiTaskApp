//
//  HomeSwiftUIView.swift
//  multiTaskApp
//
//  Created by asmaa gamal  on 15/12/2023.
//

import SwiftUI

struct HomeSwiftUIView: View {
    @State var selectedView = 1
    var body: some View {
        TabView(selection: $selectedView,
                content:  {
            AudioView().tabItem { VStack
                { Image(systemName: "mic")
                    Text("Audio")} }.tag(1)
            VideoView().tabItem {
                VStack
                { Image(systemName: "video")
                    
                    Text("Video")} }.tag(2)
            PhotoView().tabItem {
                VStack
                { Image(systemName: "photo.artframe")
                    
                    Text("Photo") }}.tag(2)
        })
    }
}

#Preview {
    HomeSwiftUIView()
}
