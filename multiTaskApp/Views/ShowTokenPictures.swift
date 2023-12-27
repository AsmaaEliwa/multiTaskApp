//
//  ShowTokenPictures.swift
//  multiTaskApp
//
//  Created by asmaa gamal  on 17/12/2023.
//
import SwiftUI

struct ShowTokenPictures: View {
    @ObservedObject  var documentDirectory: DocumentDirectoryManager
    init(){
        documentDirectory = DocumentDirectoryManager.shared
    }
    var body: some View {
//        NavigationView {
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
          
//        }

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
