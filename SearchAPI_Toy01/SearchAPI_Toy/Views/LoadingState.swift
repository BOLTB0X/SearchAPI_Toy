//
//  LoadingState.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/11.
//

import SwiftUI

// MARK: - LoadingState
// 로딩상태를 나타내나는 뷰
struct LoadingState: View {
    @Binding var progress: Double
    
    var body: some View {
        VStack(alignment: .center ,spacing: 15) {
            Text("Loading...")
                .font(.system(size: 30, weight: .bold))
                .padding()
            ProgressView(value: progress, total: 100) // 로딩 뷰
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .scaleEffect(3.0)
        }
    }
}

