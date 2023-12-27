
import SwiftUI
import AVFoundation



struct VideoPickerView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIImagePickerController
    
    var sourceType: UIImagePickerController.SourceType
    var mediaTypes: [String]
    @Binding var selectedVideo: URL?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.mediaTypes = mediaTypes
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: VideoPickerView
        
        init(parent: VideoPickerView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let videoURL = info[.mediaURL] as? URL {
                
                parent.selectedVideo = videoURL
                DocumentDirectoryManager.shared.saveVideoToDocumentDirectory(videoURL: videoURL) // Save the video to the document directory
            }
            
            picker.dismiss(animated: true)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
    
    

    
}
