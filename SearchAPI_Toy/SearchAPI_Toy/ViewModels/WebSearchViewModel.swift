//
//  WebViewModel.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/02.
//

import Foundation
import Combine

class WebSearchViewModel: ObservableObject {
    @Published var searchWeb: [Document] = []
    @Published var errorMessage = ""
    
    private var cancellables: Set<AnyCancellable> = []
    
    func fetchWebData(query: String) {
        guard let apiKey = NetworkManager.apiKey else {
            fatalError("API_KEY가 설정 X\n 번들 의심")
        }
        
        let url = URL(string: NetworkManager.webURL)!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            URLQueryItem(name: "query", value: query)
        ]
        guard let requestURL = components.url else {
            self.errorMessage = "이상한 URL"
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.setValue("KakaoAK \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: Response.self, decoder: JSONDecoder())
        // HTML 이 섞여서 받아오니 이를 정규표현식으로 걸러줘야함
            .map { response -> [Document] in
                let processedDocuments = response.documents.map { document -> Document in
                    var processedDocument = document
                    processedDocument.title = processedDocument.title.stripHTMLTags()
                    processedDocument.contents = processedDocument.contents.stripHTMLTags()
                    return processedDocument
                }
                return processedDocuments
            }
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { documents in
                self.searchWeb = documents
            })
            .store(in: &cancellables)
    }
}

extension String {
    func stripHTMLTags() -> String {
        let regex = try? NSRegularExpression(pattern: "<[^>]+>", options: .caseInsensitive)
        let range = NSRange(location: 0, length: self.count)
        return regex?.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "") ?? self
    }
}
