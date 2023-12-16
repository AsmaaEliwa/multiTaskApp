//
//  AudioView.swift
//  multiTaskApp
//
//  Created by asmaa gamal  on 15/12/2023.
//

import SwiftUI

struct AudioView: View {
    let audioRecorder = AudioManger()
    @State private var isRecording = false
    @State var process = "Start"
    @State var icon = "mic.circle"
    var body: some View {
        NavigationStack{
            VStack{
                Text("\(process) Recording")
                Button{}label: {
                    NavigationLink(destination: ShowAllAudioView()){
                        Label("Show All" , systemImage: "waveform.badge.mic")
                        
                    }
                }
                Spacer()
                Button{
                    if isRecording {
                        audioRecorder.stopRecording()
                        process = "Start"
                        icon = "mic.circle"
                    } else {
                        audioRecorder.startRecording()
                        process = "Stop"
                        icon = "mic.and.signal.meter.fill"
                    }
                    isRecording.toggle()
                }label: {
                    Image(systemName: "\(icon)") .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                }
                Spacer()
            }
            
        }}
}

#Preview {
    AudioView()
}
