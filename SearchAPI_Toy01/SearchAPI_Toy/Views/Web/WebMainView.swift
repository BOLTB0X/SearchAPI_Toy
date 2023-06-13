//
//  WebMainView.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/13.
//

import SwiftUI

struct WebMainView: View {
    var body: some View {
        NavigationView {
            ZStack {
                WebSearchView()
            }.navigationBarTitle("웹문서 검색")
        }
    }
}

struct WebMainView_Previews: PreviewProvider {
    static var previews: some View {
        WebMainView()
    }
}
