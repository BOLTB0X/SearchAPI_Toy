//
//  VclipSearchView.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/07.
//

import SwiftUI
import AVKit

struct VclipSearchView: View {
    @ObservedObject var vclipViewModel = VclipSearchViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                SearchBar(inputText: $vclipViewModel.inputText,
                          startSearch: { vclipViewModel.fetchVclipSearchData(query: vclipViewModel.inputText)
                })
                
                if !vclipViewModel.searchVclip.isEmpty {
                    LazyVStack(alignment: .center, spacing: 20) {
                        ForEach(vclipViewModel.searchVclip, id: \.id) { document in
                            
                            VStack {
                                VideoPlayer(player: AVPlayer(url: URL(string: document.url)!)) {
                                    VStack {
                                        Text("\(document.title)")
                                            .font(.headline)
                                        Spacer()
                                    }
                                }
                            }
                        }.padding()
                    }
                }
            }
        }
    }
}

struct VclipSearchView_Previews: PreviewProvider {
    static var previews: some View {
        VclipSearchView()
    }
}
