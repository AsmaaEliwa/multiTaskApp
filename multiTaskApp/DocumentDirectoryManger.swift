//
//  DocumentDirectoryManger.swift
//  multiTaskApp
//
//  Created by asmaa gamal  on 16/12/2023.
//
import Foundation
import UIKit

class DocumentDirectoryManager: ObservableObject {
    @Published var audios: [URL] = []
    @Published var images: [UIImage] = []
    let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let shared = DocumentDirectoryManager()
    private init() {
        loadFiles { url in
            if url.pathExtension == "m4a" {
                self.audios.append(url)
            } else if let image = UIImage(contentsOfFile: url.path) {
                self.images.append(image)
            }
        }
    }

    private func loadFiles(processFile: (URL) -> Void) {

        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
            for fileURL in fileURLs {
                processFile(fileURL)
            }
        } catch {
            print("Error while enumerating files \(documentDirectory.path): \(error.localizedDescription)")
        }
    }

    func saveImageToDocumentsDirectory(image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            return // Failed to get JPEG representation of the image
        }

        do {
            let uniqueFileName = "capturedImage_\(Date().timeIntervalSince1970).jpg"
            let fileURL = documentDirectory.appendingPathComponent(uniqueFileName)
            try imageData.write(to: fileURL)

            print("Image saved to: \(fileURL)")

        } catch {
            print("Error saving image:", error)
        }
    }
    
    func saveImageToDocumentsDirectoryAsPng(image: UIImage) throws -> URL {
        
        guard let imageData = image.jpegData(compressionQuality: 1) else {
            throw Manger.ConversionError.imageSaveFailed
        }
        
   
        let fileName = UUID().uuidString + ".png"
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        try imageData.write(to: fileURL)
        return fileURL
    }
    
    
    func saveVideoToDocumentDirectory(videoURL: URL) {
        let fileManager = FileManager.default
        let destinationURL = documentDirectory.appendingPathComponent("video-\(Date().timeIntervalSince1970).mp4")
        
        do {
            try fileManager.moveItem(at: videoURL, to: destinationURL)
            
            print("Video saved successfully at: \(destinationURL)")
            
        } catch {
            print("Error saving video: \(error.localizedDescription)")
            
        }
    }
    
    
    
    
}
