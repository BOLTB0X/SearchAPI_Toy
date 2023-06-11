//
//  ImageCollectionView.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/11.
//

import SwiftUI


struct ImageCollectionView: View {
    // 하위뷰이므로
    @StateObject var imgViewModel = ImageSearchViewModel()
    let gridItemLayout = [GridItem(.adaptive(minimum: 150), spacing: 10), GridItem(.adaptive(minimum: 100), spacing: 10)]
    
    var body: some View {
        // 스크롤 뷰 구성
        ScrollView {
            LazyVGrid(columns: gridItemLayout, spacing: 10) {
                ForEach(imgViewModel.searchImage, id: \.self) { document in
                    ImageCeilView(document:  document)
                        .onAppear() {
                            // 더 불러오는 지
                            imgViewModel.checkFetchMore(document: document)
                        }
                }
                .padding(5)
            }
        }
    }
}
