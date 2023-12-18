//
//  PhotoView.swift
//  multiTaskApp
//
//  Created by asmaa gamal  on 15/12/2023.
//
import SwiftUI
struct PhotoView: View {
    @State private var isShowingImagePicker = false
    @State private var image: UIImage?
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button("Take a picture") {
                        isShowingImagePicker.toggle()
                    }.padding()
                    Spacer()
                    NavigationLink(destination: ShowTokenPictures()) {
                        Text("Gallery")
                    }
                    .padding()
                }.padding()
            }
            .sheet(isPresented: $isShowingImagePicker) {
                ImagePicker(image: $image, isShown: $isShowingImagePicker)
                    .onDisappear {
                        if let image = image {
                            saveImageToDocumentsDirectory(image: image)
                            self.image = nil // Reset image state after saving
                        }
                    }
            }
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
