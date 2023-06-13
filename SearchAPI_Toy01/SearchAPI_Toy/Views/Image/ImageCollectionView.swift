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
    @Binding var showPopup: Bool // 팝업창 띄울지
    let gridItemLayout = [GridItem(.adaptive(minimum: 150), spacing: 10), GridItem(.adaptive(minimum: 100), spacing: 10)]
    
    var body: some View {
        // 스크롤 뷰 구성
            ScrollView {
                LazyVGrid(columns: gridItemLayout, spacing: 10) {
                    ForEach(imgViewModel.searchImage, id: \.self) { document in
                        ImageCellView(document:  document)
                            .onAppear() {
                                // 더 불러오는 지
                                imgViewModel.checkFetchMore(document: document)
                            }
                            .onTapGesture { // 버튼으로 만들기 귀찮아서
                                showPopup.toggle()
                                imgViewModel.updateImageDetail(document: document) // 이미지 상세 업데이트
                            }
                    }
                    .padding(5)
                }
        }
    }
}
