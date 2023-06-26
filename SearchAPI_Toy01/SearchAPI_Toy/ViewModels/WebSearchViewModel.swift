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
    // MARK: - 프로퍼티
    @Published var searchWeb: [WebDocument] = [] // 검색된 문서를 띄울 배열
    @Published var inputText = "" // 검색어를 입력받는 변수
    
    @Published var searchParam: SearchParameter = SearchParameter.getDummyData()
    
    @Published var currentPage:Int = 1 // 현재 페이지 카운트
    @Published var endPage:Bool = false // 마지막인 경우
    @Published var isLoading:Bool = false // 현재 로딩 중임을 나타낼
    @Published var loadingProgress:Double = 0.0 // 로딩 진행률
    
    var totalCount:Int = -1 // 가져올 총 데이터의 갯수
    var isTry:Bool = false // 한번이라도 실행 했는지 체크
    
    private var preQuery: String = "" // 검색어 체크를 위한
    private var totalPage:Int = -1 // 가져올 총 페이지 갯수

    private var cancellables: Set<AnyCancellable> = []
    
    init() {}
    
    // MARK: - fetchWebSearchData
    // 뷰모델에서 검색어에 관련된 WebSearchData를 가져오는 메소드
    func fetchWebSearchData(query: String) {
        // 가져오기 시작
        isLoading = true
        
        searchParam.query = query // 검색어 업데이트
        
        checkQuery(query: searchParam.query) // 검색어가 그대로인지 확인
        isTry = true
        searchParam.page = self.currentPage
        
        // NetworkManager 매니저 이용하여 URLRequest를 받아옴
        guard let request = NetworkManager.RequestURL(Url: APIEndpoint.web.path, searchParam: searchParam) else {
            print("URLRequest 생성 실패")
            isLoading = false
            return
        }
        
        // URLRequest를 통해 data를 받아옴
        guard let dataPublisher = NetworkManager.DataPublisher(forRequest: request) else {
            print("통신 에러")
            isLoading = false
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self = self else { return }
            // 받아온 data를 WebSearch에 맞게 끔 디코딩 및 파싱
            WebSearchManger.shared
                .WebSearchPublisher(dataPublisher: dataPublisher)
//                .receive(on: DispatchQueue.main) // 어차피 DispatchQueue.main.asyncAfter을 사용하므로
                .sink(receiveCompletion: { [weak self] completion in
                    self?.webOnReceive(completion)
                }, receiveValue: { [weak self] response in
                    self?.webOnReceive(response)
                })
                .store(in: &self.cancellables)
        }
    }
    
    // MARK: - FetchDataAtScroll
    // 스크롤로 데이터를 내릴대 호출
    func FetchDataAtScroll() {
        isLoading = true
        
        // 마지막까지 갔는지 체크
        guard !endPage else {
            print("다 가져옴")
            return
        }
        
        searchParam.page = self.currentPage + 1
        
        // URLRequest를 통해 data를 받아옴
        // NetworkManager 매니저 이용하여 URLRequest를 받아옴
        guard let request = NetworkManager.RequestURL(Url: APIEndpoint.web.path, searchParam: searchParam) else {
            print("URLRequest 생성 실패")
            isLoading = false
            return
        }
        
        // URLRequest를 통해 data를 받아옴
        guard let dataPublisher = NetworkManager.DataPublisher(forRequest: request) else {
            print("통신 에러")
            isLoading = false
            return
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self = self else { return }
            // 받아온 data를 WebSearch에 맞게 끔 디코딩 및 파싱
            WebSearchManger.shared
                .WebSearchPublisher(dataPublisher: dataPublisher)
                .sink(receiveCompletion: { [weak self] completion in
                    self?.webOnReceive(completion)
                }, receiveValue: { [weak self] response in
                    self?.webOnReceive(response)
                })
                .store(in: &self.cancellables)
        }
    }
    
    // MARK: - checkFetchMore
    // data를 더 가져올지 판단하는 메소드
    func checkFetchMore(document: WebDocument) {
        // 비어있지 않고 현재 document가 마지막이면
        if !searchWeb.isEmpty && document == searchWeb.last {
            FetchDataAtScroll() // 호출
            return
        }
        return
    }
    
    // MARK: - checkQuery
    // 검색어가 변했는지 체크
    private func checkQuery(query: String) -> Bool {
        // 교체 되었다면
        if query != preQuery {
            searchParam.query = query
            
            // 기존 가져왔던 data들을 다 비워져야 함
            self.currentPage = 1
            self.totalCount = -1
            self.totalPage = -1
            self.endPage = false
            self.searchWeb = []
            return true
        }
        
        preQuery = query // 검색어 교체
        return false
    }
    
    // MARK: - WebOnReceive
    //  기존에 [weak self]를 이용했던 것은 실행 중인 비동기 작업이 취소되었을 때 해당 클로저의 실행을 중단시키기 위함
    
    // 성공, 실패 등을 나눔
    private func webOnReceive(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished: // 마쳤을 경우
            self.isLoading = false // 로딩이 끝났으면 false로 설정
            self.loadingProgress = 100.0 // 로딩 되었으니
        case .failure(let error):
            print("\(error.localizedDescription)") // 에러 출력(뭔지는 알아야하기떄문)
            self.isLoading = false // 실패한 거니
            self.loadingProgress = 0.0
        }
    }
    
    private func webOnReceive(_ response: WebResponse) {
        // 이제 내가 필요한 것들을 작업
        self.currentPage += 1
        self.totalCount = response.meta?.totalCount ?? 0
        self.totalPage = response.meta?.pageableCount ?? 0
        self.loadingProgress += 50.0
        self.endPage = self.currentPage >= self.totalCount ? true : false
        self.searchWeb.append(contentsOf: response.documents) // 검색결과 배열에 넣어줌
    }
}

