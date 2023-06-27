//
//  SearchBar.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/03.
//

import SwiftUI

// MARK: - SearchBar
// 공용으로 쓸 검색 창
struct SearchBar: View {
    @Binding var btnClick: Bool
    @Binding var inputText: String // 입력 받을 텍스트
    var startSearch: () -> Void // 검색 버튼 클릭하면 동작할 클로저
    
    var body: some View {
        HStack {
            Image(systemName: !btnClick ? "d.square.fill" : "arrow.left" )
                .resizable()
                .foregroundColor(.blue)
                .frame(width: 30, height: 40)
                .cornerRadius(10)
                .onTapGesture {
                    if self.btnClick {
                        self.btnClick.toggle()
                    }
                }

            HStack {
                //Image(systemName: "magnifyingglass")
                TextField("검색 및 키워드 입력", text: $inputText, onCommit: {
                    let date = Date() // 검색 찍은 시점에 Date
                    
                    CoreDataManager.shared.saveSearchHistory(query: inputText, date: date) // 코어데이터에 넣어줌
                    startSearch() // 뷰모델의 메소드로 검색 수행
                    self.btnClick.toggle()
                })
                .onTapGesture {
                    self.btnClick = true
                }
                    .foregroundColor(.primary)
                
                if !inputText.isEmpty {
                    Button(action: {
                        self.inputText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.blue)
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
        SearchBar(btnClick: .constant(false), inputText: .constant(""), startSearch: {})
    }
}
