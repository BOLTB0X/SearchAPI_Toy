//
//  ImageCeilVie.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/10.
//

import SwiftUI

struct ImageCeilView: View {
    let document: ImageDocument
    @State private var imageLoading: Bool = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            AsyncImage(url: URL(string: document.thumbnailURL)) { image in
                image
                    .resizable()
                    .frame(width: 200, height: 100)
                    .aspectRatio(contentMode: .fit)
                
                //imageLoading = false // 로딩이 완료되었으니
            } placeholder: {
                Image("free-icon-gallery")
                    .resizable()
                    .frame(width: 200, height: 100)
                    .aspectRatio(contentMode: .fit)
                
                //imageLoading = true
            }
            
            if imageLoading {
                Text("Loading...")
            } else {
                Text("출처: \(document.displaySitename.isEmpty ? "???" : document.displaySitename)")
                    .bold()
                    .lineLimit(1)
            }
        }
    }
    
}

//struct ImageCeilView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageCeilView()
//    }
//}
