//
//  ImageSearchView.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/07.
//

import SwiftUI

struct ImageSearch: View {
    @ObservedObject var imageViewModel = ImageSearchViewModel()
    
    @State private var barClick: Bool = false
    @State private var imgClick = Bool() // 셀의 이미지를 클릭했는지

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(btnClick: $barClick ,inputText: $imageViewModel.inputText,
                          startSearch: { imageViewModel.fetchImageSearchData(query: imageViewModel.inputText)
                })
                // 검색 조건
                HStack {
                    SearchPicker(sortType: $imageViewModel.searchParam.sort, pageType: $imageViewModel.searchParam.page, sizeType: $imageViewModel.searchParam.size)
                        
                    Spacer()
                }
                
                Divider() // 구분선
                
                // 초기 화면
                if !imageViewModel.isTry {
                    Spacer()
                    HStack(alignment: .center, spacing: 15) {
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 30, height: 30)
                        Text("이미지 검색")
                            .font(.system(size: 25, weight: .bold))
                    }
                    Text("검색어를 입력해주세요")
                    Spacer()
                } else {
                    if !imageViewModel.searchImage.isEmpty {
                        // 바인딩 추가
                        ImageCollection(imgViewModel: imageViewModel, showPopup: $imgClick)
                        Text("총 게시물: \(imageViewModel.searchImage.count)/\(imageViewModel.totalCount)")
                    } else {
                        if !imageViewModel.isLoading {
                            Text("\(imageViewModel.inputText)에 대해 검색 결과가 없습니다.")
                        }
                    }
                    
                    Spacer()
                }
            }
            .overlay { // 로딩 상태 표시를 위해
                    if imageViewModel.isLoading {
                        LoadingState(progress: $imageViewModel.loadingProgress)
                    }
            }
        }
        // MARK: - 상세 팝업 뷰
        .popupNavigationView(horizontalPadding: 40, show: $imgClick) {
            ImageDetail(document: imageViewModel.imgDetail)
                .navigationTitle("상세 정보")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("닫기") {
                            withAnimation {
                                imgClick.toggle()
                            }
                        }
                    }
                }
            
        }
        // 팝업 부분
    }
}

struct ImageSearchView_Previews: PreviewProvider {
    static var previews: some View {
        ImageSearch()
    }
}
