//
//  VclipSearchView.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/07.
//

import SwiftUI

struct VclipSearch: View {
    @ObservedObject var vclipViewModel = VclipSearchViewModel()
    @State private var barClick: Bool = false
    @State private var cellClick: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                // MARK: - 검색창
                SearchBar(btnClick: $barClick ,inputText: $vclipViewModel.inputText,
                          startSearch: { vclipViewModel.fetchVclipSearchData(query: vclipViewModel.inputText)
                })
                
                if barClick {
                    SearchSub(inputText: $vclipViewModel.inputText, searchParam: $vclipViewModel.searchParam)
                }
                
                // MARK: - 초기 화면
                else if !barClick && !vclipViewModel.isTry {
                    Spacer()
                    HStack(alignment: .center, spacing: 15) {
                        Image(systemName: "video.square")                            .resizable()
                            .frame(width: 30, height: 30)
                        Text("동영상 검색")
                            .font(.system(size: 25, weight: .bold))
                    }
                    Text("검색어를 입력해주세요")
                    Spacer()
                    
                    // MARK: - 검색 결과
                } else if !barClick && vclipViewModel.isTry {
                    if !vclipViewModel.searchVclip.isEmpty {
                        ScrollView {
                            LazyVStack(alignment: .leading, spacing: 10) {
                                ForEach(vclipViewModel.searchVclip, id: \.id) { document in
                                    Button(action: {
                                        cellClick.toggle()
                                    }) {
                                        VclipCell(document: document)
                                    }
                                    
                                    .onAppear {
                                        vclipViewModel.checkFetchMore(document: document)
                                    }
                                    .sheet(isPresented: self.$cellClick) {
                                        WebView(urlToLoad: document.url)
                                    }
                                }
                            }
                            .padding(5)
                        }
                        
                        Divider() // 구분선
                        
                        Text("총 게시물: \(vclipViewModel.searchVclip.count)/\(vclipViewModel.totalCount)")
                    }  else {
                        if !vclipViewModel.isLoading {
                            Text("\(vclipViewModel.inputText)에 대해 검색 결과가 없습니다.")
                        }
                    }
                    Spacer()
                }
            }
        }
        .overlay (
            Group {
                if vclipViewModel.isLoading {
                    LoadingState(progress: $vclipViewModel.loadingProgress)
                }
            }
        )
    }
}

struct VclipSearchView_Previews: PreviewProvider {
    static var previews: some View {
        VclipSearch()
    }
}
