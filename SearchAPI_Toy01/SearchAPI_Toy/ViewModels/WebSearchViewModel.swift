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
    @Published var searchWeb: [WebDocument] = [] // 검색된 문서를 띄울 배열
    @Published var inputText = "" // 검색어를 입력받는 변수
    
    @Published var currentPage:Int = 0 // 현재 페이지 카운트
    @Published var endPage:Bool = false // 마지막인 경우
    @Published var isLoading:Bool = false // 현재 로딩 중임을 나타낼
    
    private var totalCount:Int = -1 // 가져올 총 데이터의 갯수
    private var totalPage:Int = -1 // 가져올 총 페이지 갯수
    private var cancellables: Set<AnyCancellable> = []
    
    init() {}
    
    // MARK: - fetchWebSearchData
    // 뷰모델에서 검색어에 관련된 WebSearchData를 가져오는 메소드
    func fetchWebSearchData(query: String) {
        // 마지막까지 갔는지 체크
        guard !endPage else {
            print("다 가져옴")
            return
        }
        
        // 가져오기 시작
        isLoading = true
        
        // NetworkManager 매니저 이용하여 URLRequest를 받아옴
        guard let request = NetworkManager.RequestURL(Url: APIEndpoint.web.path, query: query) else {
            print("URLRequest 생성 실패")
            isLoading = false
            return
        }
        // URLRequest를 통해 data를 받아옴
        let dataPublisher = NetworkManager.DataPublisher(forRequest: request)
        
        // 받아온 data를 WebSearch에 맞게 끔 디코딩 및 파싱
        WebSearchManger.shared
            .WebDocumentPublisher(dataPublisher: dataPublisher)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return } // 옵셔널 체이닝
                switch completion {
                case .finished: // 마쳤을 경우
                    self.isLoading = false // 로딩이 끝났으면 false로 설정
                case .failure(let error):
                    print("\(error.localizedDescription)") // 에러 출력(뭔지는 알아야하기떄문)
                    self.isLoading = false // 실패한 거니
                }
            }, receiveValue: { [weak self] documents in
                guard let self = self else { return } // 옵셔널 체이닝
                
                self.currentPage += 1
                
                self.searchWeb.append(contentsOf: documents) // 검색결과 배열에 넣어줌
                
                
            })
            .store(in: &cancellables)
    }
}

