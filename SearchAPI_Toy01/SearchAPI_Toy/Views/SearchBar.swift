//
//  SearchBar.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/03.
//

import SwiftUI

struct SearchBar: View {
    @Binding var inputText: String // 입력 받을 텍스트
    var startSearch: () -> Void // 검색 버튼 클릭하면 동작할 클로저
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("검색 및 키워드 입력", text: $inputText, onCommit: {
                    startSearch() // 뷰모델의 메소드로 검색 수행
                })
                    .foregroundColor(.primary)
                
                if !inputText.isEmpty {
                    Button(action: {
                        self.inputText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                    }
                } else {
                    EmptyView()
                }
            }
            .padding()
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)
        }
        .padding(.horizontal) // 양 옆 간격 조정
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(inputText: .constant(""), startSearch: {})
    }
}
