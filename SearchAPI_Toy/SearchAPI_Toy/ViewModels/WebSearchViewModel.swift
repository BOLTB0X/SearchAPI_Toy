//
//  WebViewModel.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/02.
//

import Foundation
import Combine

// MARK: - WebSearchViewModel
class WebSearchViewModel: ObservableObject {
    @Published var searchWeb: [WebDocument] = []
    @Published var errorMessage = ""
    @Published var inputText = ""
    
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: -
    func fetchWebSearchData(query: String) {
        // NetworkManager 매니저 이용
        let request = NetworkManager.getRequestURL(Url: APIEndpoint.web.path, query: query)
        URLSession.shared.dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main) // 받는 건 메인
            .tryMap { data, response in // data와 http 반응으로 나눠보고 확인
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: WebResponse.self, decoder: JSONDecoder()) // 해독
        // HTML 이 섞여서 받아오니 이를 정규표현식으로 걸러줘야함
            .map { response -> [WebDocument] in
                let processedDocuments = response.documents.map { document -> WebDocument in
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

// HTML 테그 정리
extension String {
    func stripHTMLTags() -> String {
        let regex = try? NSRegularExpression(pattern: "<[^>]+>", options: .caseInsensitive)
        let range = NSRange(location: 0, length: self.count)
        return regex?.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "") ?? self
    }
}
