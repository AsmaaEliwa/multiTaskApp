//
//  ConvertAPIResponse.swift
//  multiTaskApp
//
//  Created by asmaa gamal  on 25/12/2023.
//

import Foundation
struct ConvertAPIResponse: Codable {
    var ConversionCost: Int
    var Files: [FileDetail]
}

struct FileDetail: Codable {
    var FileName: String
    var FileExt: String
    var FileSize: Int
    var FileId: String
    var Url: String
}
