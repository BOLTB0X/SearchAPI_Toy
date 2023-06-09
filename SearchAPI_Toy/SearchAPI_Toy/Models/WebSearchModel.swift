//
//  WebSearchModel.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/03.
//

import Foundation

// MARK: - WebResponse
struct WebResponse: Decodable {
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

