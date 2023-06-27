//
//  BlogSearchModel.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/08.
//

import Foundation
import Combine

// MARK: - Welcome
struct BlogResponse: Codable {
    var documents: [BlogDocument]
    let meta: BlogMeta
}

// MARK: - BlogDocument
struct BlogDocument: Codable, Identifiable {
    let id = UUID()
    let blogname: String
    var contents, title: String
    let datetime: String
    let thumbnail: String
    let url: String
}

extension BlogDocument: Equatable {
    static func == (lhs: BlogDocument, rhs: BlogDocument) -> Bool {
        return lhs.id == rhs.id &&
            lhs.blogname == rhs.blogname &&
            lhs.contents == rhs.contents &&
            lhs.title == rhs.title &&
            lhs.datetime == rhs.datetime &&
            lhs.thumbnail == rhs.thumbnail &&
            lhs.url == rhs.url
    }
}

// MARK: - BlogMeta
struct BlogMeta: Codable {
    let isEnd: Bool
    let pageableCount, totalCount: Int

    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}

// MARK: - BlogSearchManger
final class BlogSearchManager {
    // 싱글톤 적용
    static let shared: BlogSearchManager = .init()
    
    // MARK: - BlogDocumentPublisher
    func BlogSearchPublisher(dataPublisher: AnyPublisher<Data, Error>) ->  AnyPublisher<BlogResponse, Error> {
        let responsePublisher = dataPublisher
        // 디코딩
            .decode(type: BlogResponse.self, decoder: JSONDecoder())
        // WebSearch 형태로 결과 쪼개기
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
