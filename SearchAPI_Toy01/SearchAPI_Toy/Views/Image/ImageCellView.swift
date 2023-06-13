//
//  ImageCeilVie.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/10.
//

import SwiftUI

struct ImageCellView: View {
    let document: ImageDocument
    @State private var imageLoading: Bool = true // 로딩 중인지 판단 용도
    @State private var showPopup = false // 팝업창 띄울지
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: document.thumbnailURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .onAppear {
                        imageLoading = false // 가리기 취소
                    }
                
            } placeholder: {
                Image("free-icon-gallery")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .onAppear {
                        imageLoading = true // 가리기
                    }
                    .redacted(reason: .placeholder)
            }
            .onTapGesture { // 버튼으로 만들기 귀찮아서
                showPopup.toggle()
            }
            
            if imageLoading {
                Text("Loading...")
                    .redacted(reason: .placeholder)
                    .font(.system(size: 25, weight: .bold))
                    .lineLimit(1)
                    .redacted(reason: .placeholder)
                Text("Loading...")
                    .lineLimit(1)
                    .font(.subheadline)
                    .redacted(reason: .placeholder)
                    .redacted(reason: .placeholder)
            } else {
                Text("\(document.displaySitename.isEmpty ? "???" : document.displaySitename)")
                    .font(.system(size: 25, weight: .bold))
                    .bold()
                    .lineLimit(1)
                Text("\(document.datetime.isEmpty ? "???" : document.datetime)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
        }// MARK: - 디테일로 이동
        .popupNavigationView(horizontalPadding: 40, show: $showPopup) {
            ImageDetailView(document: document)
                .navigationTitle("상세 정보")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("닫기") {
                            withAnimation {
                                showPopup.toggle()
                            }
                        }
                    }
                }
            
        }
    }
}

