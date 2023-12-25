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
    @State private var showingShareSheet = false // Track if the share sheet should be shown
    
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
                            .onTapGesture {
                                // When an image is tapped, show the share sheet
                                shareImage(image: image)
                            }
                    }
                }
            }
            .navigationTitle("Gallery")
            .onAppear {
                loadImagesFromDirectory()
            }
        }
        .sheet(isPresented: $showingShareSheet) {
            // Present the share sheet when showingShareSheet is true
            ActivityViewController(activityItems: images)
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
    
    func shareImage(image: UIImage) {
        // When an image is tapped, set showingShareSheet to true
        showingShareSheet = true
    }
}

// UIViewControllerRepresentable for wrapping UIKit components in SwiftUI
struct ActivityViewController: UIViewControllerRepresentable {
    let activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        return activityViewController
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // Update the view controller if needed
    }
}
