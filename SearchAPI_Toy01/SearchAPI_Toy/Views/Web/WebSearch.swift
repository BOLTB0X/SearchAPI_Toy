//
//  WebSearchView.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/03.
//

import SwiftUI

struct WebSearch: View {
    @ObservedObject var webViewModel = WebSearchViewModel()
    
    var body: some View {
        NavigationView {
            // MARK: - 검색어 관련
            VStack {
                // 검색 바
                SearchBar(inputText: $webViewModel.inputText, startSearch: {
                    webViewModel.fetchWebSearchData(query: webViewModel.inputText)
                    
                })
                // 검색 조건
                HStack {
                    SearchPicker(sortType: $webViewModel.searchParam.sort, pageType: $webViewModel.searchParam.page, sizeType: $webViewModel.searchParam.size)
                        
                    Spacer()
                }
                
                Divider() // 구분선
                
                // 초기 화면
                if !webViewModel.isTry {
                    Spacer()
                    HStack(alignment: .center, spacing: 15) {
                        Image(systemName: "doc.text")                    .resizable()
                            .frame(width: 30, height: 30)
                        Text("웹문서 검색")
                            .font(.system(size: 25, weight: .bold))
                    }
                    Text("검색어를 입력해주세요")
                    Spacer()
                } else { // 검색을 시도 했을 시
                    if !webViewModel.searchWeb.isEmpty {
                        ScrollView {
                            LazyVStack(alignment: .leading, spacing: 10) {
                                ForEach(webViewModel.searchWeb, id: \.id) { document in
                                    WebCell(webCell: document)
                                        .onAppear { // 더 불러올지 체크
                                            webViewModel.checkFetchMore(document: document)
                                        }
                                }
                                .padding(5)
                            }
                        }
                        .background(
                            Group {
                                if webViewModel.isLoading {
                                    Color.primary.opacity(0.2)
                                        .edgesIgnoringSafeArea(.all)
                                }
                            }
                        )
                        
                        Divider() // 구분선
                        
                        Text("총 게시물: \(webViewModel.searchWeb.count)/\(webViewModel.totalCount)")
                    }
                    Spacer()
                }
            }
            .overlay(
                Group {
                    // 현재 로딩 중이면?
                    if webViewModel.isLoading {
                        LoadingState(progress: $webViewModel.loadingProgress)
                        
                    }
                }
            )
        }
    }
}

struct WebSearchView_Previews: PreviewProvider {
    static var previews: some View {
        WebSearch()
    }
}