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
                WebSearch()
                    .tabItem {
                        Image(systemName: "doc.text")
                        Text("웹문서 검색")
                    }
                
                ImageSearch()
                    .tabItem {
                        Image(systemName: "photo")
                        Text("이미지 검색")
                    }
                
                VclipSearch()
                    .tabItem {
                        Image(systemName: "video.square")
                        Text("동영상 검색")
                    }
                
                BookSearch()
                    .tabItem {
                        Image(systemName: "book.fill")
                        Text("도서 검색")
                    }
                
                CafeSearch()
                    .tabItem {
                        Image(systemName: "person.3.fill")
                        Text("카페 검색")
                    }
                
                BlogSearch()
                    .tabItem {
                        Image(systemName: "b.circle.fill")
                        Text("블로그 검색")
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
