//
//  AudioManger.swift
//  multiTaskApp
//
//  Created by asmaa gamal  on 15/12/2023.
//

import Foundation
import AVFAudio
class AudioManger: NSObject, AVAudioRecorderDelegate {
    var audioRecorder: AVAudioRecorder!
    
    func startRecording() {
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
//            try audioSession.setActive(true)
            
            let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let audioFilename = documentsPath.appendingPathComponent("\(Date()) recording.m4a")
            
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
//                AVSampleRateKey: 44100,
//                AVNumberOfChannelsKey: 2,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ] as [String : Any]
            
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
        } catch {
            // Handle error
            print("Recording failed")
        }
    }
    
    func stopRecording() {
        audioRecorder.stop()
    }
}
