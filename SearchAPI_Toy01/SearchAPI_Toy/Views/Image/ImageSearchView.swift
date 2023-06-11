//
//  ImageSearchView.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/07.
//

import SwiftUI

struct ImageSearchView: View {
    @ObservedObject var imageViewModel = ImageSearchViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(inputText: $imageViewModel.inputText,
                          startSearch: { imageViewModel.fetchImageSearchData(query: imageViewModel.inputText)
                })
                
                // 초기 화면
                if !imageViewModel.isTry {
                    Text("검색어를 입력해주세요")
                    Spacer()
                } else {
                    if !imageViewModel.searchImage.isEmpty {
                        ImageCollectionView(imgViewModel: imageViewModel)
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
    }
}

struct ImageSearchView_Previews: PreviewProvider {
    static var previews: some View {
        ImageSearchView()
    }
}
