//
//  ContentView.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/02.
//

import SwiftUI

struct ContentView: View {
    @State var isLoading: Bool = true
    
    var body: some View {
        ZStack {
            Main()
         
            if isLoading { // 로딩 중일때 띄울거
                LaunchScreenView
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                isLoading.toggle()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
