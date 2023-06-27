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
                            Button(action: {
                                self.inputText = history.query!
                            }) {
                                Text(history.query ?? "")
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
                                    .frame(width: 20, height: 20)
                            }
                            // 기존 DefaultButtonStyle으로 하면 이미지 버튼이 포함된 셀을 클릭하면 리스트셀 내 버튼을 클릭하지 않아도 클릭했다고 인식해버리므로 버튼 스타일 변경
                            .buttonStyle(BorderlessButtonStyle()
                            )
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
