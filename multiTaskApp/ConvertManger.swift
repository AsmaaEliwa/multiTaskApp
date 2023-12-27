//
//  ConvertManger.swift
//  multiTaskApp
//
//  Created by asmaa gamal  on 25/12/2023.
//

import Foundation
import SwiftUI
class ConvertManger{
    static let shared = ConvertManger()
    private init(){}
    func convertImage(image: UIImage, completion: @escaping (Result<UIImage, Error>) -> Void) {
        

        guard let url = URL(string: "https://v2.convertapi.com/convert/jpg/to/png?Secret=LjZ15uxsy7Vd5uiq") else {
            
                  completion(.failure(ConversionError.invalidURL))
            
                  return
              }

              var request = URLRequest(url: url)
              request.httpMethod = "POST"
              request.addValue("application/json", forHTTPHeaderField: "Content-Type")
      
              guard let imageData = image.jpegData(compressionQuality: 0.6) else {
                  completion(.failure(ConversionError.encodingError))
                  
                  return
              }
              let base64EncodedImage = imageData.base64EncodedString()

        let json: [String: Any] = [
            "Parameters": [
                [
                    "Name": "File",
                    "FileValue": [
                        "Name": "\(base64EncodedImage).jpg",
                        "Data": base64EncodedImage
                    ]
                ],
                [
                    "Name": "StoreFile",
                    "Value": true
                ]
            ]
        ]

        guard let jsonData = try? JSONSerialization.data(withJSONObject: json) else {
            
            return
        }
        
        request.httpBody = jsonData
        
        
        
        


        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                // Handle network error
                print("Error: \(error)")
                return
            }
            
            if let data = data{
                
                Manger.shared.handleConversionResponse(data: data) { result  in
                    
                }
                           
                       } else {
                           // Handle conversion failure
                       }
                   }

                   task.resume()
               }

          enum ConversionError: Error {
              case invalidURL, encodingError, invalidResponse
          }
    
    
      }

class Manger {
    static let shared = Manger()
    private init(){}
    func handleConversionResponse(data: Data, completion: @escaping (Result<URL, Error>) -> Void) {
        // Decode the JSON response
        do {
            let response = try JSONDecoder().decode(ConvertAPIResponse.self, from: data)
            guard let fileUrlString = response.Files.first?.Url,
                  let fileUrl = URL(string: fileUrlString) else {
                completion(.failure(ConversionError.invalidResponse))
                return
            }
            
            // Download the image
            downloadImage(from: fileUrl) { result in
                switch result {
                case .success(let image):
                    // Save the image to the document directory
                    do {
                        let savedUrl = try DocumentDirectoryManager.shared.saveImageToDocumentsDirectoryAsPng(image: image)
                        
                        completion(.success(savedUrl))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch {
            completion(.failure(ConversionError.decodingError))
        }
    }

    enum ConversionError: Error {
        case invalidResponse
        case decodingError
        case imageDownloadFailed
        case imageSaveFailed
    }

    func downloadImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data, let image = UIImage(data: data) else {
                completion(.failure(ConversionError.imageDownloadFailed))
                return
            }
            completion(.success(image))
        }.resume()
    }

   

}
