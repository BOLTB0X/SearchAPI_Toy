//
//  Search.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/20.
//

import SwiftUI

// MARK: - Search
// 검색 화면
struct SearchSub: View {
    @StateObject var searchHistory = SearchHistoryViewModel()
    
    @State private var isDelete:Bool = false
    @Binding var inputText: String // 입력 받을 텍스트
    @Binding var searchParam: SearchParameter
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Divider()
            
            // 검색 조건
            SearchPicker(sortType: $searchParam.sort, pageType: $searchParam.page, sizeType: $searchParam.size)
            
            // 검색 기록
            List {
                Section(header: Text("검색 기록")) {
                    ForEach(searchHistory.searchHistory, id:\.id) { history in
                        HStack {
                            Text(history.query ?? "")
                                .onTapGesture {
                                    self.inputText = history.query!
                                }
                            
                            Spacer()
                            Button(action: {
                                withAnimation {
                                    searchHistory.searchHistory.removeAll(where: { $0.id == history.id })
                                    CoreDataManager.shared.deleteSearchHistory(searchHistory: history)
                                }
                            }) {
                                Image(systemName: "x.circle")
                                    .resizable()
                                    .foregroundColor(.blue)
                                    .frame(width: 15, height: 15)
                            }
                            //.buttonStyle(PlainButtonStyle())
                            .transition(.slide) // 옆으로 가게끔
                            .animation(.easeIn)
                        }
                    }
                }
            }
        }.listStyle(.grouped)
    }
}

// 미리보기
struct Search_Previews: PreviewProvider {
    static var previews: some View {
        let text = Binding.constant("")
        let searchParam = Binding.constant(SearchParameter.getDummyData())
        return SearchSub(inputText: text, searchParam: searchParam)
    }
}
