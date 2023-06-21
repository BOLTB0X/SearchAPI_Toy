//
//  WebSearchView.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/03.
//

import SwiftUI

struct WebSearch: View {
    @ObservedObject var webViewModel = WebSearchViewModel()
    @State private var barClick: Bool = false
    
    var body: some View {
        NavigationView {
            // MARK: - 검색어 관련
            VStack {
                
                SearchBar(btnClick: $barClick ,inputText: $webViewModel.inputText, startSearch: {
                    webViewModel.fetchWebSearchData(query: webViewModel.inputText)
                })
                
                if barClick {
                    SearchSub(inputText: $webViewModel.inputText, searchParam: $webViewModel.searchParam)
                }
                // MARK: - 초기 화면
                else if !barClick && !webViewModel.isTry {
                    Spacer()
                    HStack(alignment: .center, spacing: 15) {
                        Image(systemName: "doc.text")                    .resizable()
                            .frame(width: 30, height: 30)
                        Text("웹문서 검색")
                            .font(.system(size: 25, weight: .bold))
                    }
                    Text("검색어를 입력해주세요")
                    Spacer()
                    
                // MARK: - 결과 화면
                } else if !barClick && webViewModel.isTry { // 검색을 시도 했을 시
                    if !webViewModel.searchWeb.isEmpty {
                        // 검색 결과
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
                        .background( // 로딩할떄 배경
                            Group {
                                if webViewModel.isLoading {
                                    Color.primary.opacity(0.2)
                                        .edgesIgnoringSafeArea(.all)
                                }
                            }
                        )
                        
                        Divider() // 구분선
                        
                        Text("총 게시물: \(webViewModel.searchWeb.count)/\(webViewModel.totalCount)")
                    } else {
                        if !webViewModel.isLoading {
                            Spacer()
                            Text("\(webViewModel.inputText)에 대해 검색 결과가 없습니다.")
                        }
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
