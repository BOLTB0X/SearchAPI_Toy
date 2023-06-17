//
//  WebCeilView.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/08.
//

import SwiftUI

struct WebCellView: View {
    let webCell: WebDocument
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // 제목 클릭시 원본 링크로
            NavigationLink(destination: WebView(urlToLoad: webCell.url), label: {
                // 제목
                Text(webCell.title)
                    .font(.system(size: 25, weight: .bold))
                    .bold()
                    .lineLimit(1) // 한줄로 제한
            })
            
            // 내용
            Text(webCell.contents)
                .bold()
                .foregroundColor(.secondary)
                .lineLimit(3) // 두 줄로 제한
            
            // 등록 일자
            Text(webCell.datetime)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(1) // 한줄로 제한
        }
        .padding(.horizontal)
    }
}
