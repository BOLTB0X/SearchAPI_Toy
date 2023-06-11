//
//  NetworkManager.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/02.
//

import Foundation
import Combine

// MARK: - APIEndpoint
// 사용할 URL을 열거형 이용해봄
enum APIEndpoint {
    case web
    case vclip
    case image
    case cafe
    case book
    case blog
    
    // 선택에 따라
    var path: String {
        switch self {
        case .web:
            return "https://dapi.kakao.com/v2/search/web"
        
        case .vclip:
            return "https://dapi.kakao.com/v2/search/vclip"
        
        case .image:
            return "https://dapi.kakao.com/v2/search/image"
       
        case .cafe:
            return "https://dapi.kakao.com/v2/search/cafe"
        
        case .book:
            return "https://dapi.kakao.com/v3/search/book"
        
        case .blog:
            return "https://dapi.kakao.com/v2/search/blog"
        }
    }
}

// MARK: - NetworkManager
// 각 API 별 공통적으로 쓸 메소드들을 정의
// 복잡한 로직이 필요하지 않아 enum 이용
enum NetworkManager {
    // MARK: - apiKey: 번들로 apiKey 가져오기
    static var apiKey: String? {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            fatalError("Info.plist안에 API_KEY가 연결이 안됨")
        }
        return apiKey
    }
    
        
    // MARK: - RequestURL
    // 요청할 URL을 반환하는 메소드
    static func RequestURL(Url:String , query: String, sortType: String? = nil, page: Int? = nil, pageSize: Int? = nil, targetField: String? = nil) -> URLRequest? {
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
        
        if let target = targetField {
            components.queryItems?.append(URLQueryItem(name: "target", value: String(target)))
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
    
    // MARK: - DataPublisher
    // URLRequest를 파라미터로 디코딩 되지 않은 data를 반환하는 메소드
    static func DataPublisher(forRequest: URLRequest) -> AnyPublisher<Data, Error>? {
        URLSession.shared
            .dataTaskPublisher(for: forRequest)
            .receive(on: DispatchQueue.main) // 받는 것 메인
            // 요청했은니 데이터와 에러를 나눠 확인
            .tryMap { data, response in
                // HTTPURLResponse이고 상태코드가 200이여만 함
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse) // 아님 에러를 던지고
                }
                return data // 맞으면 디코딩되지 않은 data를 반환
            }
            .eraseToAnyPublisher() // 지금까지의 데이터 스트림이 어떠했던 최종적인 형태의 Publisher를 리턴
    }
    
}
