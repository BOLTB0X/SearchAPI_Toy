//
//  WebSearchModel.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/03.
//

import Foundation

// MARK: - Response
struct Response: Decodable {
    let meta: Meta?
    let documents: [Document]
}

// MARK: - Document
struct Document: Codable, Identifiable {
    let id = UUID()
    var datetime, contents, title: String
    let url: String
}

// MARK: - Meta
struct Meta: Codable {
    let totalCount, pageableCount: Int
    let isEnd: Bool

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case pageableCount = "pageable_count"
        case isEnd = "is_end"
    }
}


extension Document: Equatable {
    static func == (lhs: Document, rhs: Document) -> Bool {
        return lhs.id == rhs.id &&
               lhs.datetime == rhs.datetime &&
               lhs.contents == rhs.contents &&
               lhs.title == rhs.title &&
               lhs.url == rhs.url
    }
}
