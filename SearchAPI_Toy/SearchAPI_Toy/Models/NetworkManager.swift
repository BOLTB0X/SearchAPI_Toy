//
//  NetworkManager.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/02.
//

import Foundation

// MARK: - NetworkManager
// 네트워크 관련
enum NetworkManager {
    // MARK: - apiKey: 번들로 apiKey 가져오기
    static var apiKey: String? {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            fatalError("Info.plist안에 API_KEY가 연결이 안됨")
        }
        return apiKey
    }
    
    // MARK: - URL
    static let webURL:String = "https://dapi.kakao.com/v2/search/web"
    static let vclipURL:String = "https://dapi.kakao.com/v2/search/vclip"
    static let imageURL:String = "https://dapi.kakao.com/v2/search/image"
    
    // MARK: - getRequestURL
    // 요청할 URL을 반환하는 메소드
    static func getRequestURL(Url:String , query: String, sortType: String? = nil, page: Int? = nil, pageSize: Int? = nil) -> URLRequest {
        guard let apiKey = NetworkManager.apiKey else {
            fatalError("API_KEY가 설정 X\n 번들 의심")
        }
        
        let url = URL(string: Url)!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        // 쿼리(검색어)는 필수
        components.queryItems = [
            URLQueryItem(name: "query", value: query)
        ]
        
        // 선택사항인 요청 파라미터
        if let sort = sortType {
            components.queryItems?.append(URLQueryItem(name: "sort", value: sort))
        }
        if let page = page {
            components.queryItems?.append(URLQueryItem(name: "page", value: String(page)))
        }
        if let size = pageSize {
            components.queryItems?.append(URLQueryItem(name: "size", value: String(size)))
        }
        
        // 마지막 체크
        guard let requestURL = components.url else {
            fatalError("잘못된 URL")
        }
        
        // 이제 API 인증 후 요청
        var retURL = URLRequest(url: requestURL)
        retURL.setValue("KakaoAK \(apiKey)", forHTTPHeaderField: "Authorization")
        retURL.httpMethod = "GET"
        
        return retURL
    }
}
