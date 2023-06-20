//
//  BookSearch.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/19.
//

import SwiftUI

struct BookSearch: View {
    var body: some View {
        NavigationView {
            VStack {
                
                HStack(alignment: .center, spacing: 15) {
                    Image(systemName: "book.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                    Text("도서 검색")
                        .font(.system(size: 25, weight: .bold))
                }
            }
        }
    }
}

struct BookSearch_Previews: PreviewProvider {
    static var previews: some View {
        BookSearch()
    }
}
