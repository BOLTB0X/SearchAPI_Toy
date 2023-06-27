//
//  CafeSearch.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/19.
//

import SwiftUI

struct CafeSearch: View {
    @ObservedObject var cafeViewModel = CafeSearchViewModel()
    @State private var barClick: Bool = false
    @State private var cellCick: Bool = false // 셀 전용
    
    var body: some View {
        NavigationView {
            VStack {
                // MARK: - 검색창
                SearchBar(btnClick: $barClick ,inputText: $cafeViewModel.inputText,
                          startSearch: { cafeViewModel.fetchCafeSearchData(query: cafeViewModel.inputText)
                })
                
                if barClick {
                    SearchSub(inputText: $cafeViewModel.inputText, searchParam: $cafeViewModel.searchParam)
                }
                
                // MARK: - 초기화면
                else if !barClick && !cafeViewModel.isTry {
                    Spacer()
                    HStack(alignment: .center, spacing: 15) {
                        Image(systemName: "person.3.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                        Text("카페 검색")
                            .font(.system(size: 25, weight: .bold))
                    }
                    Text("검색어를 입력해주세요")
                    Spacer()
                    // MARK: - 검색결과
                } else {
                    if !barClick && !cafeViewModel.searchCafes.isEmpty {
                        ScrollView {
                            LazyVStack(alignment: .leading, spacing: 10) {
                                ForEach(cafeViewModel.searchCafes, id: \.id) { document in
                                    Button(action: {
                                        cellCick.toggle()
                                    }) {
                                        CardView(title: document.title, cate: document.cafename, imgURL: document.thumbnail, date: document.datetime)
                                    }
                                    .sheet(isPresented: self.$cellCick) {
                                        WebView(urlToLoad: document.url)
                                    }
                                    .onAppear {
                                        cafeViewModel.checkFetchMore(document: document)
                                    }
                                }
                            }
                            .padding(5)
                        }
                        Text("총 게시물: \(cafeViewModel.searchCafes.count)/\(cafeViewModel.totalCount)")
                    } else {
                        if !cafeViewModel.isLoading {
                            Text("\(cafeViewModel.inputText)에 대해 검색 결과가 없습니다.")
                        }
                    }
                    Spacer()
                }
            }
        }
        .overlay(
            Group {
                if cafeViewModel.isLoading {
                    LoadingState(progress: $cafeViewModel.loadingProgress)
                }
            }
        )
    }
}

struct CafeSearch_Previews: PreviewProvider {
    static var previews: some View {
        CafeSearch()
    }
}
