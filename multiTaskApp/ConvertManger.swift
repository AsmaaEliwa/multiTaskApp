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
         let apiKey = "260383269"
             guard let url = URL(string: "https://v2.convertapi.com/convert/png/to/jpg?Secret=\(apiKey)") else {
            completion(.failure(ConversionError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let imageData = image.pngData()
        let json = ["File": imageData?.base64EncodedString() ?? ""]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: json, options: [])
        } catch {
            completion(.failure(ConversionError.encodingError))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data,
                  let convertedImageData = Data(base64Encoded: data),
                  let convertedImage = UIImage(data: convertedImageData) else {
                completion(.failure(ConversionError.invalidResponse))
                return
            }

            completion(.success(convertedImage))
        }

        task.resume()
    }

    enum ConversionError: Error {
        case invalidURL
        case encodingError
        case invalidResponse
    }

}
