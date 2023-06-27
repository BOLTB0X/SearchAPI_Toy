//
//  BlogSearch.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/19.
//

import SwiftUI

struct BlogSearch: View {
    @ObservedObject var blogViewModel = BlogSearchViewModel()
    @State private var barClick: Bool = false
    @State private var cellCick: Bool = false // 셀 전용
    
    var body: some View {
        NavigationView {
            VStack {
                // MARK: - 검색창
                SearchBar(btnClick: $barClick ,inputText: $blogViewModel.inputText,
                          startSearch: { blogViewModel.fetchBlogSearchData(query: blogViewModel.inputText)
                })
                
                if barClick {
                    SearchSub(inputText: $blogViewModel.inputText, searchParam: $blogViewModel.searchParam)
                }
                
                // MARK: - 초기화면
                else if !barClick && !blogViewModel.isTry {
                    Spacer()
                    HStack(alignment: .center, spacing: 15) {
                        Image(systemName: "b.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                        Text("블로그 검색")
                            .font(.system(size: 25, weight: .bold))
                    }
                    Text("검색어를 입력해주세요")
                    Spacer()
                    // MARK: - 검색결과
                } else {
                    if !barClick && !blogViewModel.searchBlogs.isEmpty {
                        ScrollView {
                            LazyVStack(alignment: .leading, spacing: 10) {
                                ForEach(blogViewModel.searchBlogs, id: \.id) { document in
                                    Button(action: {
                                        cellCick.toggle()
                                    }) {
                                        
                                        CardView(title: document.title, cate: document.blogname, imgURL: document.thumbnail, date: document.datetime)
                                    }
                                    .sheet(isPresented: self.$cellCick) {
                                        WebView(urlToLoad: document.url)
                                    }
                                    .onAppear {
                                        blogViewModel.checkFetchMore(document: document)
                                    }
                                }
                            }
                            .padding(5)
                        }
                        Text("총 게시물: \(blogViewModel.searchBlogs.count)/\(blogViewModel.totalCount)")
                    } else {
                        if !blogViewModel.isLoading {
                            Text("\(blogViewModel.inputText)에 대해 검색 결과가 없습니다.")
                        }
                    }
                    Spacer()
                }
            }
        }
        .overlay(
            Group {
                if blogViewModel.isLoading {
                    LoadingState(progress: $blogViewModel.loadingProgress)
                }
            }
        )
    }
}

struct BlogSearch_Previews: PreviewProvider {
    static var previews: some View {
        BlogSearch()
    }
}
