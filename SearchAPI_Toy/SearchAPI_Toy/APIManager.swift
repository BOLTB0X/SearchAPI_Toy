//
//  APIManager.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/02.
//

import Foundation

// MARK: - APIManager
enum APIManager {
    static var apiKey: String? {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "DAUM_API_KEY") as? String else {
            fatalError("Info.plist안에 DAUM_API_KEY가 연결이 안됨")
        }
        return apiKey
    }
}
