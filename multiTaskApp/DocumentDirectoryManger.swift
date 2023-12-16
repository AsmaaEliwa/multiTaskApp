//
//  DocumentDirectoryManger.swift
//  multiTaskApp
//
//  Created by asmaa gamal  on 16/12/2023.
//

import Foundation
class DocumentDirectoryManger: ObservableObject{
    @Published var audios: [URL] = []
    static let shared = DocumentDirectoryManger()
    private init(){
        audios = getAudioFilesFromDirectory()
    }
    
    func getAudioFilesFromDirectory() -> [URL] {
        let fileManager = FileManager.default
        var audioFiles: [URL] = []

        do {
            let documentsURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let directoryContents = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)

            // Filter files to only include audio files (modify as needed based on file extensions)
            audioFiles = directoryContents.filter { $0.pathExtension == "m4a" /* Add more extensions if needed */ }

        } catch {
            print("Error while enumerating files: \(error.localizedDescription)")
        }

        return audioFiles
    }
    
}
