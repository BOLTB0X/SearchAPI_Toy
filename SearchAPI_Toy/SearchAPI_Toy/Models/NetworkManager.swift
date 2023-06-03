//
//  NetworkManager.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/02.
//

import Foundation
import Combine

// MARK: - NetworkManager
// 네트워크 관련
enum NetworkManager {
    static var apiKey: String? {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            fatalError("Info.plist안에 API_KEY가 연결이 안됨")
        }
        return apiKey
    }
    
    static let webURL:String = "https://dapi.kakao.com/v2/search/web"
    static let vclipURL:String = "https://dapi.kakao.com/v2/search/vclip"
    static let imageURL:String = "https://dapi.kakao.com/v2/search/image"
}
