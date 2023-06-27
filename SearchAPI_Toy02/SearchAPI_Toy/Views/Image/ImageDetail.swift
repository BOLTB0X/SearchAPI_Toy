//
//  ImageDetailView.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/13.
//

import SwiftUI

struct ImageDetail: View {
    let document: ImageDocument
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: document.thumbnailURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: CGFloat(document.width), height: CGFloat(document.height))
                    .aspectRatio(contentMode: .fit)
            }
            VStack(alignment: .leading) {
                Text("출처: \(document.displaySitename)")
                    .font(.subheadline)
                
                NavigationLink(destination: WebView(urlToLoad: document.docURL), label: {
                    // 제목
                    Text("원본 보기")
                        .font(.subheadline)
                })
                
                Text("원본 크기: \(document.width) X \(document.height)")
                    .font(.subheadline)
            }
        }
        .padding()
    }
}

