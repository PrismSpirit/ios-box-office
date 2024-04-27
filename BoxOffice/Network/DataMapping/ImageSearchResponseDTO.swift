//
//  ImageSearchResponseDTO.swift
//  BoxOffice
//
//  Created by Prism, Gray on 4/23/24.
//

struct ImageSearchResponseDTO: Decodable {
    let documents: [DocumentDTO]
}

extension ImageSearchResponseDTO {
    struct DocumentDTO: Decodable {
        private enum CodingKeys: String, CodingKey {
            case collection
            case datetime
            case displaySiteName = "display_sitename"
            case docURL = "doc_url"
            case imageURL = "image_url"
            case thumbnailURL = "thumbnail_url"
            case width
            case height
        }
        
        let collection: String
        let datetime: String
        let displaySiteName: String
        let docURL: String
        let imageURL: String
        let thumbnailURL: String
        let width: Int
        let height: Int
    }
}

extension ImageSearchResponseDTO.DocumentDTO {
    func toModel() -> Document {
        return .init(docURL: docURL,
                     imageURL: imageURL,
                     width: width,
                     height: height)
    }
}
