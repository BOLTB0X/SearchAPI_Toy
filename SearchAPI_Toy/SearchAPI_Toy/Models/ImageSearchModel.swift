//
//  ImageSearchModel.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/03.
//

import Foundation

// MARK: - ImageResponse
struct ImageResponse: Codable {
    let meta: ImageMeta?
    let documents: [ImageDocument]
}

// MARK: - ImageDocument
struct ImageDocument: Codable, Identifiable {
    let id = UUID()
    var datetime: String
    let collection: String
    let thumbnailURL: String
    let imageURL: String
    let width: Int
    let height: Int
    let displaySitename: String
    let docURL: String
}

extension ImageDocument: Equatable {
    static func == (lhs: ImageDocument, rhs: ImageDocument) -> Bool {
        return lhs.id == rhs.id &&
               lhs.datetime == rhs.datetime &&
               lhs.collection == rhs.collection &&
               lhs.thumbnailURL == rhs.thumbnailURL &&
               lhs.imageURL == rhs.imageURL &&
               lhs.width == rhs.width &&
               lhs.height == rhs.height &&
               lhs.displaySitename == rhs.displaySitename &&
               lhs.docURL == rhs.docURL
    }
}

// MARK: - ImageMeta
struct ImageMeta: Codable {
    let totalCount, pageableCount: Int
    let isEnd: Bool

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case pageableCount = "pageable_count"
        case isEnd = "is_end"
    }
}
