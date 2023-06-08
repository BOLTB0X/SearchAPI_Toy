//
//  WebCeilView.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/08.
//

import SwiftUI

struct WebCeilView: View {
    let webCeil: WebDocument
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // 제목 클릭시 원본 링크로
            Link(destination: URL(string: webCeil.url)!, label: {
                // 제목
                Text(webCeil.title)
                    .font(.system(size: 25, weight: .bold))
                    .bold()
                    .lineLimit(1) // 한줄로 제한
            })
            
            // 내용
            Text(webCeil.contents)
                .bold()
                .foregroundColor(.secondary)
                .lineLimit(3) // 두 줄로 제한
            
            // 등록 일자
            Text(webCeil.datetime)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.horizontal)
    }
}

//struct WebCeilView_Previews: PreviewProvider {
//    static var previews: some View {
//        WebCeilView()
//    }
//}
