//
//  Search.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/20.
//

import SwiftUI

struct Search: View {
    @State private var click:Bool = false
    @Binding var inputText: String // 입력 받을 텍스트
    var startSearch: () -> Void // 검색 버튼 클릭하면 동작할 클로저
    
    var body: some View {
        VStack {
            // 검색 바
            SearchBar(inputText: $inputText, startSearch: {
                startSearch()
            })
        }
    }
}

struct Search_Previews: PreviewProvider {
    
    static var previews: some View {
        let text = Binding.constant("")
        return Search(inputText: text, startSearch: {})
    }
}
