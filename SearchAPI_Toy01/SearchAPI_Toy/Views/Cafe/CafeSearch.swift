//
//  CafeSearch.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/19.
//

import SwiftUI

struct CafeSearch: View {
    var body: some View {
        NavigationView {
            VStack {
                
                HStack(alignment: .center, spacing: 15) {
                    Image(systemName: "person.3.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                    Text("카페 검색")
                        .font(.system(size: 25, weight: .bold))
                }
            }
        }

    }
}

struct CafeSearch_Previews: PreviewProvider {
    static var previews: some View {
        CafeSearch()
    }
}
