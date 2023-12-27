//
//  ImageDetailView.swift
//  multiTaskApp
//
//  Created by asmaa gamal  on 25/12/2023.
//

import SwiftUI

struct ImageDetailView: View {
    var image: UIImage
       @State private var showingShareSheet = false

       var body: some View {
           VStack {
               Image(uiImage: image)
                   .resizable()
                   .aspectRatio(contentMode: .fit)

               Button("Share") {
                   showingShareSheet = true
               }
               .padding()
               .sheet(isPresented: $showingShareSheet) {
                   ActivityViewController(activityItems: [image])
               }

               Button("Convert to Png") {
                   ConvertManger.shared.convertImage(image: image) { result in
                    
                       
                       
                   }
               }
               .padding()
           }
           .navigationBarTitle("Image Detail", displayMode: .inline)
       }
   }
