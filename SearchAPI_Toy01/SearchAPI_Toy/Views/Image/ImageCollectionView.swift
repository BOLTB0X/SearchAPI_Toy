//
//  CollectionView.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/10.
//

import SwiftUI

struct ImageCollectionView: View {
    var searchImage = [ImageDocument]()
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                ForEach(searchImage, id: \.self) { document in
                    ImageCeilView(document: document)
                }
            }
        }
    }
}

//struct CollectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageCollectionView()
//    }
//}
