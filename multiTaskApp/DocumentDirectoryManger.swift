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
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Could not find the documents directory.")
            return
        }

        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
            for fileURL in fileURLs {
                processFile(fileURL)
            }
        } catch {
            print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
        }
    }

    func saveImageToDocumentsDirectory(image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            return // Failed to get JPEG representation of the image
        }

        do {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let uniqueFileName = "capturedImage_\(Date().timeIntervalSince1970).jpg"
            let fileURL = documentsDirectory.appendingPathComponent(uniqueFileName)
            try imageData.write(to: fileURL)

            print("Image saved to: \(fileURL)")

        } catch {
            print("Error saving image:", error)
        }
    }
    
    
    
    
}
