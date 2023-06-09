//
//  Extension+View.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/13.
//

import SwiftUI

extension View {
    // MARK: - popupNavigationView
    // popup 커스텀
    func popupNavigationView<Content: View>(horizontalPadding: CGFloat = 40, show: Binding<Bool>, @ViewBuilder content: @escaping ()->Content) -> some View {
        return self
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .overlay {
                if show .wrappedValue {
                    GeometryReader { proxy in
                        
                        Color.primary
                            .opacity(0.15)
                            .ignoresSafeArea()
                        
                        let size = proxy.size
                        
                        NavigationView {
                            content()
                        }
                        .frame(width: size.width - horizontalPadding, height: size.height / 1.7, alignment: .center)
                        .cornerRadius(15)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }
                }
            }
    }
}

extension ContentView {
    var LaunchScreenView: some View {
        ZStack(alignment: .center) {
            LinearGradient(gradient: Gradient(colors: [Color(.blue), Color(.gray)]),
                                        startPoint: .top, endPoint: .bottom)
                        .edgesIgnoringSafeArea(.all)
            
            Image(systemName: "d.circle.fill")
                .resizable()
                .foregroundColor(.blue)
                .frame(width: 200, height: 200)
        }
    }
}
