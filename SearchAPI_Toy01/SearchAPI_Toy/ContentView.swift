//
//  ContentView.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/02.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            WebSearchView()
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
