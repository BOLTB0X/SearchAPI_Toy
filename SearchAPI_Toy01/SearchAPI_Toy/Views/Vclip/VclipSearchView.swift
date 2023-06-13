//
//  VclipSearchView.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/07.
//

import SwiftUI

struct VclipSearchView: View {
    @ObservedObject var vclipViewModel = VclipSearchViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(inputText: $vclipViewModel.inputText,
                          startSearch: { vclipViewModel.fetchVclipSearchData(query: vclipViewModel.inputText)
                })
                
                // 초기 화면
                if !vclipViewModel.isTry {
                    Text("검색어를 입력해주세요")
                    Spacer()
                } else {
                    if !vclipViewModel.searchVclip.isEmpty {
                        ScrollView {
                            LazyVStack(alignment: .leading, spacing: 10) {
                                ForEach(vclipViewModel.searchVclip, id: \.id) { document in
                                    VclipCellView(document: document)
                                        .onAppear {
                                            vclipViewModel.checkFetchMore(document: document)
                                        }
                                }
                            }
                            .padding(5)
                        }
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
        VclipSearchView()
    }
}
