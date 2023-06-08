//
//  CafeSearchModel.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/08.
//

import Foundation
import Combine

// MARK: - CafeResponse
struct CafeResponse: Codable {
    var documents: [CafeDocument]
    let meta: CafeMeta
}

// MARK: - CafeDocument
struct CafeDocument: Codable, Identifiable {
    let id = UUID()
    let cafename: String
    var contents, title: String
    let datetime: String
    let thumbnail: String
    let url: String
}

extension CafeDocument: Equatable {
    static func == (lhs: CafeDocument, rhs: CafeDocument) -> Bool {
        return lhs.id == rhs.id &&
            lhs.cafename == rhs.cafename &&
            lhs.contents == rhs.contents &&
            lhs.datetime == rhs.datetime &&
            lhs.thumbnail == rhs.thumbnail &&
            lhs.title == rhs.title &&
            lhs.url == rhs.url
    }
}

// MARK: - CafeMeta
struct CafeMeta: Codable {
    let isEnd: Bool
    let pageableCount, totalCount: Int

    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}

// MARK: - CafeSearchManager
final class CafeSearchManager {
    static let shared: CafeSearchManager = .init() // 싱글톤
    
    // MARK: - CafeSearchPublisher
    func CafeSearchPublisher(dataPublisher: AnyPublisher<Data, Error>) -> AnyPublisher<CafeResponse, Error> {
        let responsePublisher = dataPublisher
            .decode(type: CafeResponse.self, decoder: JSONDecoder())
            .map { response in
                var streamedResponse = response
                streamedResponse.documents = response.documents.map { document in
                    var streamedDocument = document
                    streamedDocument.title = streamedDocument.title.stripHTMLTags()
                    streamedDocument.contents = streamedDocument.contents.stripHTMLTags()
                    return streamedDocument // 테그 제거 완료
                }
                return streamedResponse // html 테그 띤 Response를 반환
            }
            .eraseToAnyPublisher()
        return responsePublisher
    }
}
