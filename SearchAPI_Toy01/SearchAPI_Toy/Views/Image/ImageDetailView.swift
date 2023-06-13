//
//  ImageDetailView.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/13.
//

import SwiftUI

struct ImageDetailView: View {
    let document: ImageDocument
    
    var body: some View {
        VStack {
            Text("원본: \(document.docURL)")
            Text("출처: \(document.displaySitename)")
            Text("가로:\(document.width) 세로:(\(document.height)")
        }
    }
}

