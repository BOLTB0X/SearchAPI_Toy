//
//  ContentView.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/02.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var webViewModel = WebSearchViewModel()
    
    var body: some View {
        VStack {
            List(webViewModel.searchWeb) { webResult in
                VStack(alignment: .leading) {
                    Text(webResult.title)
                        .font(.headline)
                    Text(webResult.contents)
                        .font(.subheadline)
                }
            }
            .onAppear {
                webViewModel.fetchWebData(query: "에스파")
            }
            
            // 만약 받아오는게 실패한다면
            if !webViewModel.errorMessage.isEmpty {
                Text(webViewModel.errorMessage)
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
