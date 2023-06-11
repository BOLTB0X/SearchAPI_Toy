//
//  ImageCeilVie.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/10.
//

import SwiftUI

struct ImageCeilView: View {
    let document: ImageDocument
    @State private var imageLoading: Bool = true // 로딩 중인지 판단 용도
    
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
            
            if imageLoading {
                Text("Loading...")
                    .redacted(reason: .placeholder)
                Text("Loading...")
                    .redacted(reason: .placeholder)
            } else {
                Text("출처: \(document.displaySitename.isEmpty ? "???" : document.displaySitename)")
                    .bold()
                    .lineLimit(1)
                Text("게시일: \(document.datetime.isEmpty ? "???" : document.datetime)")
                    .bold()
                    .lineLimit(1)
            }
        }
    }
    
}

