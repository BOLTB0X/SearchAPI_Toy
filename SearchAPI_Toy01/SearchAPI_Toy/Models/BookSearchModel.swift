//
//  BookSearchModel.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/08.
//

import Foundation
import Combine

// MARK: - BookResponse
struct BookResponse: Codable {
    let meta: BookMeta
    var documents: [BookDocument]
}

// MARK: - BookDocument
struct BookDocument: Codable, Identifiable {
    let id = UUID()
    let authors: [String]
    let contents, datetime, isbn: String
    let price: Int
    let publisher: String
    let salePrice: Int
    let status: String
    let thumbnail: String
    let title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case authors, contents, datetime, isbn, price, publisher
        case salePrice = "sale_price"
        case status, thumbnail, title, translators, url
    }
}

extension BookDocument: Equatable {
    static func == (lhs: BookDocument, rhs: BookDocument) -> Bool {
        return lhs.id == rhs.id &&
            lhs.authors == rhs.authors &&
            lhs.contents == rhs.contents &&
            lhs.datetime == rhs.datetime &&
            lhs.isbn == rhs.isbn &&
            lhs.price == rhs.price &&
            lhs.publisher == rhs.publisher &&
            lhs.salePrice == rhs.salePrice &&
            lhs.status == rhs.status &&
            lhs.thumbnail == rhs.thumbnail &&
            lhs.title == rhs.title &&
            lhs.url == rhs.url
    }
}

// MARK: - BookMeta
struct BookMeta: Codable {
    let totalCount, pageableCount: Int
    let isEnd: Bool
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case pageableCount = "pageable_count"
        case isEnd = "is_end"
    }
}

// MARK: - BookSearchManger
final class BookSearchManger {
    // 싱글톤 적용
    static let shared: BookSearchManger = .init()
    
    // MARK: - WebDocumentPublisher
    func BookSearchPublisher(dataPublisher: AnyPublisher<Data, Error>) ->  AnyPublisher<BookResponse, Error> {
        let responsePublisher = dataPublisher
        // 디코딩
            .decode(type: BookResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        return responsePublisher
    }
}
