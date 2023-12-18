//
//  ShowTokenPictures.swift
//  multiTaskApp
//
//  Created by asmaa gamal  on 17/12/2023.
//

import SwiftUI

struct ShowTokenPictures: View {
    let fileManager = FileManager.default
       @State private var images: [UIImage] = []
       
       var body: some View {
           NavigationView {
               ScrollView {
                   LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                       ForEach(images, id: \.self) { image in
                           Image(uiImage: image)
                               .resizable()
                               .aspectRatio(contentMode: .fill)
                               .frame(width: 100, height: 100)
                               .cornerRadius(8)
                       }
                   }
               }
               .navigationTitle("Gallery")
               .onAppear {
                   loadImagesFromDirectory()
               }
           }
       }
       
       func loadImagesFromDirectory() {
           let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
           
           do {
               let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
               for fileURL in fileURLs {
                   if let image = UIImage(contentsOfFile: fileURL.path) {
                       images.append(image)
                   }
               }
           } catch {
               print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
           }
       }
   }
