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
                    LazyVStack(alignment: .leading, spacing: 10) {
                        ForEach(imageViewModel.searchImage, id: \.id) { document in
                            
                            AsyncImage(url: URL(string: document.thumbnailURL)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            } placeholder: {
                                ProgressView()
                                    .scaleEffect(5.0)
                            }
                            //                                .frame(width: CGFloat(document.width), height: CGFloat(document.height))
                        }
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
