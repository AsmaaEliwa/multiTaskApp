//
//  PhotoView.swift
//  multiTaskApp
//
//  Created by asmaa gamal  on 15/12/2023.
//
import SwiftUI
struct PhotoView: View {
    @State  var isShowingImagePicker = false
    @State  var image: UIImage?
    
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
                            DocumentDirectoryManager.shared.saveImageToDocumentsDirectory(image: image)
                            self.image = nil // Reset image state after saving
                        }
                    }
            }
        }
    }
    
    
}
