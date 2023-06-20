//
//  Search.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/20.
//

import SwiftUI

// MARK: - Search
// 검색 화면
struct Search: View {
    @StateObject var searchHistory = SearchHistoryViewModel()
    @State private var click:Bool = false
    @Binding var inputText: String // 입력 받을 텍스트
    @Binding var searchParam: SearchParameter
    var startSearch: () -> Void // 검색 버튼 클릭하면 동작할 클로저
    
    var body: some View {
        VStack {
            HStack {
                // 검색 바
                SearchBar(inputText: $inputText, startSearch: {
                    startSearch()
                })
                Button(action: {
                    click.toggle()
                    print("click")
                }) {
                    Image(systemName: "paperplane")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
            }
            .padding(.horizontal)
            
            // 검색 조건
            HStack {
                SearchPicker(sortType: $searchParam.sort, pageType: $searchParam.page, sizeType: $searchParam.size)
                    
                Spacer()
            }
            
            Divider() // 구분선
            
            List {
                
            }
        }
    }
}

// 미리보기
struct Search_Previews: PreviewProvider {
    static var previews: some View {
        let text = Binding.constant("")
        let searchParam = Binding.constant(SearchParameter.getDummyData())
        return Search(inputText: text, searchParam: searchParam, startSearch: {})
    }
}
