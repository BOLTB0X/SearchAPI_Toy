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
            VStack(alignment: .center, spacing: 5) {
                SearchBar(inputText: $webViewModel.inputText, startSearch: {
                    webViewModel.fetchWebSearchData(query: webViewModel.inputText)
                })
                
                if !webViewModel.searchWeb.isEmpty {
                    List(webViewModel.searchWeb, id: \.title) { document in
                        VStack(alignment: .leading) {
                            Text(document.title)
                                .font(.headline)
                            Text(document.contents)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                } else {
                    Text("검색 결과가 없습니다.")
                        .foregroundColor(.secondary)
                }
            }
        }.navigationTitle("Daum 웹문서 검색: \(webViewModel.inputText)")
    }
}

struct WebSearchView_Previews: PreviewProvider {
    static var previews: some View {
        WebSearchView()
    }
}
