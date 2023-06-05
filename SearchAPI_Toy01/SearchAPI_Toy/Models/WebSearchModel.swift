//
//  WebSearchModel.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/03.
//

import Foundation
import Combine

// MARK: - WebResponse
struct WebResponse: Codable {
    let meta: WebMeta?
    let documents: [WebDocument]
}

// MARK: - WebDocument
struct WebDocument: Codable, Identifiable {
    let id = UUID()
    var datetime, contents, title: String
    let url: String
}

extension WebDocument: Equatable {
    static func == (lhs: WebDocument, rhs: WebDocument) -> Bool {
        return lhs.id == rhs.id &&
        lhs.datetime == rhs.datetime &&
        lhs.contents == rhs.contents &&
        lhs.title == rhs.title &&
        lhs.url == rhs.url
    }
}

// MARK: - WebMeta
struct WebMeta: Codable {
    let totalCount, pageableCount: Int
    let isEnd: Bool
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case pageableCount = "pageable_count"
        case isEnd = "is_end"
    }
}

// MARK: - WebSearchManger
// DataPublisher로 받아온 data를 WebSearchModel 형태로 디코딩 및 파싱용
final class WebSearchManger {
    // 싱글톤 적용
    static let shared: WebSearchManger = .init()
    
    // MARK: - WebDocumentPublisher
    func WebDocumentPublisher(dataPublisher: AnyPublisher<Data, Error>) ->  AnyPublisher<[WebDocument], Error> {
        let documentsPublisher = dataPublisher
        // 디코딩
            .decode(type: WebResponse.self, decoder: JSONDecoder())
        // WebSearch 형태로 결과 쪼개기
            .map { response -> [WebDocument] in
                let processedDocuments = response.documents.map { document -> WebDocument in
                    var processedDocument = document
                    processedDocument.title = processedDocument.title.stripHTMLTags()
                    processedDocument.contents = processedDocument.contents.stripHTMLTags()
                    return processedDocument
                }
                return processedDocuments
            }
            .eraseToAnyPublisher()
        return documentsPublisher
    }
}

// HTML 테그 정리
extension String {
    func stripHTMLTags() -> String {
        let regex = try? NSRegularExpression(pattern: "<[^>]+>", options: .caseInsensitive)
        let range = NSRange(location: 0, length: self.count)
        return regex?.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "") ?? self
    }
}
