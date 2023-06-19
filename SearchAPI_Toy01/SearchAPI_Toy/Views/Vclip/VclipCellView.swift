//
//  VclipCellView.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/12.
//

import SwiftUI

struct VclipCellView: View {
    let document: VclipDocument
    @State private var imageLoading: Bool = true // 로딩 중인지 판단 용도
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: document.thumbnail)) { image in
                Link(destination: URL(string: document.url)!, label: {
                    image
                        .resizable()
                        .frame(width: 180, height: 100)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(8)
                        .onAppear {
                            imageLoading = false // 가리기 취소
                        }
                })
                
            } placeholder: {
                Image("free-icon-gallery")
                    .resizable()
                    .frame(width: 180, height: 100)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
                    .onAppear {
                        imageLoading = true // 가리기
                    }
                    .redacted(reason: .placeholder)
            }
            
            VStack(alignment: .leading) { // 영상관련
                if imageLoading {
                    Text("Loading...")
                        .font(.system(size: 15, weight: .bold))
                        .lineLimit(1)
                        .redacted(reason: .placeholder)
                } else {
                    Text("\(document.title)")
                        .font(.system(size: 15, weight: .bold))
                        .fontWeight(.bold)
                        .bold()
                        .lineLimit(1) // 한줄로 제한
                }
                
                Spacer()
                VStack(alignment: .leading) {
                    // 로딩 줄일때
                    if imageLoading {
                        Spacer()
                        Text("Loading...")
                            .lineLimit(1)
                            .font(.system(size: 10, weight: .light))
                            .redacted(reason: .placeholder)
                        Text("Loading...")
                            .lineLimit(1)
                            .font(.system(size: 10, weight: .light))
                            .redacted(reason: .placeholder)
                    }
                    else {
                        Spacer()
                        Text("\(document.author)")
                            .font(.system(size: 10, weight: .light))
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                        Text("\(document.datetime)")
                            .font(.system(size: 10, weight: .light))
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                        
                        NavigationLink(destination: WebView(urlToLoad: document.url), label: {
                            // 제목
                            Text("원본 보기")
                                .font(.footnote)
                        })
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding(4)
        }
        .padding(8)
    }
}

