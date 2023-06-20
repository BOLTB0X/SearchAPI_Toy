//
//  BookSearchViewModel.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/19.
//

import Foundation
import Combine

// MARK: - BookSearchViewModel
class BookSearchViewModel: ObservableObject {
    @Published var searchBook: [BookDocument] = [] // 검색된 문서를 담아둘 배열
    @Published var inputText = "" // 검색어를 입력받는 변수
    
    //@Published var imgDetail: BookDocument = BookDocument.getDummyData() // 이미지 상세 정보
    @Published var searchParam: SearchParameter = SearchParameter.getDummyData()
    
    // 무한 스크롤 관련
    @Published var currentPage:Int = 0 // 현재 페이지 카운트
    @Published var endPage:Bool = false // 마지막인 경우
    @Published var isLoading:Bool = false // 현재 로딩 중임을 나타낼
    
    @Published var loadingProgress:Double = 0.0 // 로딩 진행률
    
    var totalCount:Int = -1 // 가져올 총 데이터의 갯수
    var isTry:Bool = false // 한번이라도 실행했는지
    
    private var preQuery: String = "" // 검색어 체크용
    private var totalPage:Int = -1 // 가져올 총 페이지 갯수
    private var cancellables: Set<AnyCancellable> = []
    
    init() { }
    
    // MARK: - fetchBookSearchData
    func fetchBookSearchData(query: String) {
        guard !endPage else {
            print("마지막 페이지")
            return
        }
        
        searchParam.query = query // 검색어 업데이트
        checkQuery(query: searchParam.query) // 검색어가 그대로인지 확인

        // start
        isLoading = true
        isTry = true
        
        // NetworkManager 매니저 이용하여 URLRequest를 받아옴
        guard let request = NetworkManager.RequestURL(Url: APIEndpoint.book.path, searchParam: searchParam) else {
            print("URLRequest 생성 실패")
            isLoading = false // false로 변경
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
            BookSearchManager.shared
                .bookSearchPublisher(dataPublisher: dataPublisher)
                .sink(receiveCompletion: { [weak self] completion in
                    self?.bookOnReeive(completion)
                }, receiveValue: { [weak self] response in
                    self?.bookOnReeive(response)
                })
                .store(in: &self.cancellables)
        }
    }
    
    // MARK: - checkFetchMore
    func checkFetchMore(document: BookDocument) {
        // 현재 document가 마지막이면
        if !searchBook.isEmpty &&
            document == searchBook.last {
            fetchBookSearchData(query: inputText)
            return
        }
        return
    }
    
    // MARK: - checkQuery
    // 검색어가 변했는지 체크
    private func checkQuery(query: String) {
        // 교체 되었다면
        if query != preQuery {
            preQuery = query // 검색어 교체
            
            // 기존 가져왔던 data들을 다 비워져야 함
            self.currentPage = 0
            self.totalCount = -1
            self.totalPage = -1
            self.endPage = false
            self.searchBook = []
        }
        
        return
    }
    
    // MARK: - bookOnReeive
    // 성공, 실패 등을 나눔
    private func bookOnReeive(_ completion: Subscribers.Completion<Error>) {
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
    
    private func bookOnReeive(_ response: BookResponse) {
        // 이제 내가 필요한 것들을 작업
        self.currentPage += 1
        self.totalCount = response.meta.totalCount
        self.totalPage = response.meta.pageableCount
        self.loadingProgress += 50.0
        self.endPage = self.currentPage >= self.totalCount ? true : false
        
        self.searchBook.append(contentsOf: response.documents) // 검색결과 배열에 넣어줌
    }

}
