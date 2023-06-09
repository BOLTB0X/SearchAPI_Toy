//
//  WebSearchView.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/03.
//

import SwiftUI

struct WebSearchView: View {
    @ObservedObject var webViewModel = WebSearchViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(inputText: $webViewModel.inputText, startSearch: {
                    webViewModel.fetchWebSearchData(query: webViewModel.inputText)
                    
                })
                // 초기 화면
                if !webViewModel.isTry {
                    Text("검색어를 입력해주세요")
                    Spacer()
                } else { // 검색을 시도 했을 시
                    if !webViewModel.searchWeb.isEmpty {
                        ScrollView {
                            LazyVStack(alignment: .leading, spacing: 10) {
                                ForEach(webViewModel.searchWeb, id: \.id) { document in
                                    WebCeilView(webCeil: document)
                                        .onAppear { // 더 불러올지 체크
                                            webViewModel.checkFetchMore(document: document)
                                        }
                                }
                                .padding(5)
                            }
                        }
                        Text("\(webViewModel.inputText)  관련 총 게시물: \(webViewModel.totalCount)")
                    }
                    Spacer()
                }
            }
            .overlay(
                Group {
                    // 현재 로딩 중이면?
                    if webViewModel.isLoading {
                        VStack(alignment: .center ,spacing: 15) {
                            Text("Loading...")
                                .font(.system(size: 30, weight: .bold))
                                .padding()
                            ProgressView(value: webViewModel.loadingProgress, total: 100) // 로딩 뷰
                                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                                .scaleEffect(3.0)
                        }
                        
                    }
                }
            )
        }
    }
}

struct WebSearchView_Previews: PreviewProvider {
    static var previews: some View {
        WebSearchView()
    }
}
