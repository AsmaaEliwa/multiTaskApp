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
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .onTapGesture {
                        saveImageToDocumentsDirectory(image: image)
                    }
            } else {
                Button {
                    isShowingImagePicker.toggle()
                }label: {
                    Image(systemName: "camera.on.rectangle").resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                }
            }
        }
        .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: $image, isShown: $isShowingImagePicker)
        }
    }

    func loadImage() {
        // Handle the loaded image
        // You can perform additional actions here with the captured image
    }

    func saveImageToDocumentsDirectory(image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            return // Failed to get JPEG representation of the image
        }

        do {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = documentsDirectory.appendingPathComponent("capturedImage.jpg")
            try imageData.write(to: fileURL)
            print("Image saved to: \(fileURL)")
        } catch {
            print("Error saving image:", error)
        }
    }
}
