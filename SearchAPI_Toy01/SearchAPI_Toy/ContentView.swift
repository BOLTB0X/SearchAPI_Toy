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
            TabView {
                WebMainView()
                    .tabItem {
                        Image(systemName: "doc.text")
                        Text("웹문서 검색")
                    }
                
                ImageSearchView()
                    .tabItem {
                        Image(systemName: "photo")
                        Text("이미지 검색")
                    }
                
                VclipSearchView()
                    .tabItem {
                        Image(systemName: "video.square")
                        Text("동영상 검색")
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
