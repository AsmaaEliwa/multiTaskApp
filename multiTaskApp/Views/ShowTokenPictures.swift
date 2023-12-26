//
//  ShowTokenPictures.swift
//  multiTaskApp
//
//  Created by asmaa gamal  on 17/12/2023.
//
import SwiftUI

struct ShowTokenPictures: View {
    @State  var documentDirectory: DocumentDirectoryManager
    @State  var showingShareSheet = false // Track if the share sheet should be shown
    init(){
        documentDirectory = DocumentDirectoryManager.shared
    }
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                                ForEach(documentDirectory.images, id: \.self) { image in
                                    NavigationLink(destination: ImageDetailView(image: image)) {
                                        Image(uiImage: image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 100, height: 100)
                                            .cornerRadius(8)
                                    }
                    }
                }
            }
            .navigationTitle("Gallery")
          
        }
        .sheet(isPresented: $showingShareSheet) {
            // Present the share sheet when showingShareSheet is true
            ActivityViewController(activityItems: documentDirectory.images)
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
