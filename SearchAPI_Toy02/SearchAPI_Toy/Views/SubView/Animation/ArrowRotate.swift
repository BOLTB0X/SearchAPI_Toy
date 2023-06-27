//
//  ArrowRotate.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/19.
//

import SwiftUI

// MARK: - ArrowRotate
// 새로고침할때 쓸라함
// 원본: https://stackoverflow.com/questions/58315628/repeating-animation-on-swiftui-image?rq=1
struct ArrowRotate: View {
    @State var angle: Double = 0.0
    

    var body: some View {
        Image(systemName: "arrow.2.circlepath")
            .resizable()
            .frame(width: 70, height: 70)
            .rotationEffect(Angle(degrees: self.angle))
            .onAppear {
                withAnimation(Animation.linear(duration: 2.0).repeatForever(autoreverses: false)) {
                    self.angle = 360.0
                }
            }
        
    }
}

struct ArrowRotate_Previews: PreviewProvider {
    static var previews: some View {
        ArrowRotate()
    }
}
