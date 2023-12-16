//
//  AudioManger.swift
//  multiTaskApp
//
//  Created by asmaa gamal  on 15/12/2023.
//

import Foundation
import AVFAudio
import AVKit
import AVFoundation
class AudioManger: NSObject, AVAudioRecorderDelegate {
    static let shared = AudioManger()
    var audioRecorder: AVAudioRecorder!
    var viewController: UIViewController?
    func startRecording() {
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true)
            
            let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let uniqueID = UUID().uuidString // Generate a unique identifier using UUID
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyyMMdd_HHmmss" // Define a date format for additional uniqueness
            let currentDate = formatter.string(from: Date()) // Get current date/time as a string
            let audioFilename = documentsPath.appendingPathComponent("\(currentDate)_\(uniqueID).m4a")
            
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
   
            print("Recording failed")
        }
    }
    
    func stopRecording() {
        audioRecorder.stop()
    }
    
    
    
    func playAudioFromURL(audioURL: URL) {
           guard let viewController = self.viewController else {
               print("View controller reference not set")
               return
           }

           let player = AVPlayer(url: audioURL)
           let playerViewController = AVPlayerViewController()
           playerViewController.player = player

           // Present the player view controller modally from the provided view controller
           viewController.present(playerViewController, animated: true) {
               player.play()
           }
       }
    
    
}
