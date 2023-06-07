//
//  ImageSearchViewModel.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/07.
//

import Foundation
import Combine

// MARK: - ImageSearchViewModel
class ImageSearchViewModel: ObservableObject {
    @Published var searchImage: [ImageDocument] = [] // 검색된 문서를 담아둘 배열
    @Published var inputText = "" // 검색어를 입력받는 변수
    
    // 무한 스크롤 관련
    @Published var currentPage:Int = 0
    @Published var endPage:Bool = false
    @Published var isLoading:Bool = false
    
    private var totalCount:Int = -1 // 가져올 총 데이터의 갯수
    private var totalPage:Int = -1 // 가져올 총 페이지 갯수
    private var cancellables: Set<AnyCancellable> = []
    
    init() { }
    
    // MARK: - fetchImageSearchData
    func fetchImageSearchData(query: String) {
        guard !endPage else {
            print("마지막 페이지")
            return
        }
        
        // start
        isLoading = true
        
        // NetworkManager 매니저 이용하여 URLRequest를 받아옴
        guard let request = NetworkManager.RequestURL(Url: APIEndpoint.image.path, query: query) else {
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
        
        ImageSearchManager.shared
            .ImageSearchPublisher(dataPublisher: dataPublisher)
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
                
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                
                self.currentPage += 1
                self.totalCount = response.meta?.totalCount ?? 0
                self.totalPage = response.meta?.pageableCount ?? 0
                self.endPage = self.currentPage >= self.totalCount ? true : false
                
                self.searchImage.append(contentsOf: response.documents)
            })
            .store(in: &cancellables)
    }
}
