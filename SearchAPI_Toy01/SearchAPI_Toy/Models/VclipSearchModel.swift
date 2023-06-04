//
//  VclipSearchModel.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/03.
//

import Foundation

// MARK: - VclipResponse
struct VclipResponse: Codable {
    let meta: VclipMeta?
    let documents: [VclipDocument]
}

// MARK: - VclipDocument
struct VclipDocument: Codable, Identifiable {
    let id = UUID()
    var datetime: String
    let title: String
    let playTime: Int
    let thumbnailURL: String
    let url: String
    let author: String
}

extension VclipDocument: Equatable {
    static func == (lhs: VclipDocument, rhs: VclipDocument) -> Bool {
        return lhs.id == rhs.id &&
               lhs.datetime == rhs.datetime &&
               lhs.title == rhs.title &&
               lhs.playTime == rhs.playTime &&
               lhs.thumbnailURL == rhs.thumbnailURL &&
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

