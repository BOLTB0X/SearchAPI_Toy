//
//  VclipSearchModel.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/03.
//

import Foundation
import Combine

// MARK: - VclipResponse
struct VclipResponse: Codable {
    let meta: VclipMeta?
    var documents: [VclipDocument]
}

// MARK: - VclipDocument
struct VclipDocument: Codable, Identifiable {
    let id = UUID()
    let author: String
    var datetime: String
    let playTime: Int
    let thumbnail: String
    let title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case author, datetime
        case playTime = "play_time"
        case thumbnail, title, url
    }
}

extension VclipDocument: Equatable {
    static func == (lhs: VclipDocument, rhs: VclipDocument) -> Bool {
        return lhs.id == rhs.id &&
               lhs.datetime == rhs.datetime &&
               lhs.title == rhs.title &&
               lhs.playTime == rhs.playTime &&
               lhs.thumbnail == rhs.thumbnail &&
               lhs.url == rhs.url &&
               lhs.author == rhs.author
    }
}

// MARK: - VclipMeta
struct VclipMeta: Codable {
    let totalCount, pageableCount: Int
    let isEnd: Bool

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case pageableCount = "pageable_count"
        case isEnd = "is_end"
    }
}

// MARK: - VclipSearchManager
final class VclipSearchManager {
    static let shared:VclipSearchManager = .init()
    
    // MARK: - VclipSearchPublisher
    func VclipSearchPublisher(dataPublisher: AnyPublisher<Data, Error>) -> AnyPublisher<VclipResponse, Error> {
        let responsePublisher = dataPublisher
            .decode(type: VclipResponse.self, decoder: JSONDecoder())
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
