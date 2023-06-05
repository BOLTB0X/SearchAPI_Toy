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
        ScrollView {
            SearchBar(inputText: $webViewModel.inputText, startSearch: {
                webViewModel.fetchWebSearchData(query: webViewModel.inputText)
            })
            
            if !webViewModel.searchWeb.isEmpty {
                LazyVStack(alignment: .leading, spacing: 10) {
                    ForEach(webViewModel.searchWeb, id: \.id) { document in
                        VStack(alignment: .leading) {
                            // TODO
                            Text(document.title)
                                .font(.headline)
                            Text(document.contents)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .onAppear {
                            if !webViewModel.searchWeb.isEmpty && (document == webViewModel.searchWeb.last) {
                                webViewModel.fetchWebSearchData(query: webViewModel.inputText)
                            }
                        }
                    }
                }.padding()
            } else {
                Text("검색 결과가 없습니다.")
                    .foregroundColor(.secondary)
            }
        }.navigationTitle("Daum 웹문서 검색: \(webViewModel.inputText)")
        
    }
}

struct WebSearchView_Previews: PreviewProvider {
    static var previews: some View {
        WebSearchView()
    }
}
