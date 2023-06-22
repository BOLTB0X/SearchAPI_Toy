//
//  BookSearch.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/19.
//

import SwiftUI

struct BookSearch: View {
    @ObservedObject var bookViewModel = BookSearchViewModel()
    @State private var barClick: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                // MARK: - 검색창
                SearchBar(btnClick: $barClick ,inputText: $bookViewModel.inputText,
                          startSearch: { bookViewModel.fetchBookSearchData(query: bookViewModel.inputText)
                })
                
                if barClick {
                    SearchSub(inputText: $bookViewModel.inputText, searchParam: $bookViewModel.searchParam)
                }
                
                // MARK: - 초기화면
                else if !barClick && !bookViewModel.isTry {
                    Spacer()
                    HStack(alignment: .center, spacing: 15) {
                        Image(systemName: "book.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                        Text("도서 검색")
                            .font(.system(size: 25, weight: .bold))
                    }
                    Text("검색어를 입력해주세요")
                    Spacer()
                    
                // MARK: - 검색결과
                } else {
                    if !barClick && !bookViewModel.searchBook.isEmpty {
                        ScrollView {
                            VStack(alignment: .leading, spacing: 10) {
                                ForEach(bookViewModel.searchBook, id: \.id) { document in
                                    Text(document.title)
                                        .onAppear {
                                            bookViewModel.checkFetchMore(document: document)
                                        }
                                }
                            }
                            .padding(5)
                        }
                        Text("총 게시물: \(bookViewModel.searchBook.count)/\(bookViewModel.totalCount)")
                    } else {
                        if !bookViewModel.isLoading {
                            Text("\(bookViewModel.inputText)에 대해 검색 결과가 없습니다.")
                        }
                    }
                    Spacer()
                }
            }
        }
        .overlay(
            Group {
                if bookViewModel.isLoading {
                    LoadingState(progress: $bookViewModel.loadingProgress)
                }
            }
        )
    }
}

struct BookSearch_Previews: PreviewProvider {
    static var previews: some View {
        BookSearch()
    }
}
