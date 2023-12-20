
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
                   parent.saveVideoToDocumentDirectory(videoURL: videoURL) // Save the video to the document directory
               }
               
               picker.dismiss(animated: true)
           }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }


    func saveVideoToDocumentDirectory(videoURL: URL) {
        let fileManager = FileManager.default
        let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let destinationURL = documentsPath.appendingPathComponent("video-\(Date().timeIntervalSince1970).mp4")

        do {
            try fileManager.moveItem(at: videoURL, to: destinationURL)
            
            print("Video saved successfully at: \(destinationURL)")
            
        } catch {
            print("Error saving video: \(error.localizedDescription)")
            
        }
    }
   
}
