//
//  ImageCeilVie.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/10.
//

import SwiftUI

struct ImageCell: View {
    let document: ImageDocument
    @State private var imageLoading: Bool = true // 로딩 중인지 판단 용도
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: document.thumbnailURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
                    .onAppear {
                        imageLoading = false // 가리기 취소
                    }
                
            } placeholder: {
                Image("free-icon-gallery")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
                    .onAppear {
                        imageLoading = true // 가리기
                    }
                    .redacted(reason: .placeholder)
            }
            
            if imageLoading {
                Text("Loading...")
                    .redacted(reason: .placeholder)
                    .font(.system(size: 20, weight: .bold))
                    .lineLimit(1)
                    .redacted(reason: .placeholder)
                
                Text("Loading...")
                    .lineLimit(1)
                    .font(.subheadline)
                    .redacted(reason: .placeholder)
                
            } else {
                Text("\(document.displaySitename.isEmpty ? "???" : document.displaySitename)")
                    .font(.system(size: 20, weight: .bold))
                    .bold()
                    .lineLimit(1)
                
                Text("\(document.datetime.isEmpty ? "???" : document.datetime)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
        }
    }
}

