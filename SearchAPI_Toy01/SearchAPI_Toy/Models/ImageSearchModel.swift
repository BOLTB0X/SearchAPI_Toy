//
//  ImageSearchModel.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/03.
//

import Foundation
import Combine

// MARK: - ImageResponse
struct ImageResponse: Codable {
    let meta: ImageMeta?
    var documents: [ImageDocument]
}

// MARK: - ImageDocument
struct ImageDocument: Codable, Identifiable, Hashable {
    let id = UUID()
    var collection: Collection
    var datetime: String
    var displaySitename: String
    var docURL: String
    var height: Int
    var imageURL: String
    var thumbnailURL: String
    var width: Int
    
    enum Collection: String, Codable {
        case blog = "blog"
        case cafe = "cafe"
        case etc = "etc"
        case news = "news"
    }

    enum CodingKeys: String, CodingKey {
        case collection, datetime
        case displaySitename = "display_sitename"
        case docURL = "doc_url"
        case height
        case imageURL = "image_url"
        case thumbnailURL = "thumbnail_url"
        case width
    }
    
    // MARK: - getDummyData
    static func getDummyData() -> ImageDocument {
        // 더미
        let dummy = ImageDocument(collection: .blog, datetime: "", displaySitename: "", docURL: "", height: 0, imageURL: "", thumbnailURL: "", width: 0)
        return dummy
    }
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

// MARK: - ImageSearchManager
final class ImageSearchManager {
    static let shared: ImageSearchManager = .init() // 싱글톤
    
    // MARK: - ImageSearchPublisher
    func ImageSearchPublisher(dataPublisher: AnyPublisher<Data, Error>) -> AnyPublisher<ImageResponse, Error> {
        let responsePublisher = dataPublisher
        // 디코딩
            .decode(type: ImageResponse.self, decoder: JSONDecoder())
            .map { response in
                var streamedResponse = response
                streamedResponse.documents = response.documents.map { document in
                    var streamedDocument = document
                    streamedDocument.datetime = streamedDocument.datetime.fomatDateTime()!
                    return streamedDocument
                }
                return streamedResponse
            }
            .eraseToAnyPublisher()
        return responsePublisher
    }
}
