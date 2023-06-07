//
//  ImageSearchView.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/07.
//

import SwiftUI

struct ImageSearchView: View {
    @ObservedObject var imageViewModel = ImageSearchViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                SearchBar(inputText: $imageViewModel.inputText,
                          startSearch: { imageViewModel.fetchImageSearchData(query: imageViewModel.inputText)
                })
                
                if !imageViewModel.searchImage.isEmpty {
                    LazyVStack(alignment: .center, spacing: 20) {
                        ForEach(imageViewModel.searchImage, id: \.id) { document in
                            
                            VStack {
                                AsyncImage(url: URL(string: document.thumbnailURL)) { image in
                                    image
                                        .resizable()
                                        .frame(width: 200, height: 100)
                                        .aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    ProgressView()
                                        .scaleEffect(3.0)
                                }
                            }                            .onAppear {
                                if !imageViewModel.searchImage.isEmpty && (document == imageViewModel.searchImage.last) {
                                    imageViewModel.fetchImageSearchData(query: imageViewModel.inputText)
                                }
                            }
                        }.padding()
                    }
                }
            }
        }
    }
}

struct ImageSearchView_Previews: PreviewProvider {
    static var previews: some View {
        ImageSearchView()
    }
}
