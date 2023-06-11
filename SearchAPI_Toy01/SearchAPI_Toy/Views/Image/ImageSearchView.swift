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
                        ImageCollectionView(searchImage: imageViewModel.searchImage)
        
                        }
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
