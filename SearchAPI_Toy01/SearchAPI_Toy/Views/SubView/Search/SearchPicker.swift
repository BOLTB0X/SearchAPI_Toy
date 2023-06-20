//
//  SearchPicker.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/14.
//

import SwiftUI

// MARK: - SearchPicker
struct SearchPicker: View {
    @State private var selectedIdx1: Int = 0 // sort
    @State private var selectedIdx2: Int = 0 // 불러올 페이지 수
    @State private var selectedIdx3: Int = 0 // 불러올 페이지 수
    
    // 연결할 Binding
    @Binding var sortType:String?
    @Binding var pageType:Int?
    @Binding var sizeType:Int?
    
    let sortedArr = ["acc", "rec"] // 정렬 기준
    let pagesArr = [1, 5, 10, 15] // 페이지 수
    let sizeArr = [10, 20, 30, 40] // 보여질 문서 수
    
    var body: some View {
        HStack(spacing: 15) {
            Text("검색 조건: ")
            
            Picker("정렬", selection: $selectedIdx1) {
                ForEach(sortedArr.indices, id: \.self) { i in
                    Text(sortedArr[i])
                }
            }
            .pickerStyle(.menu)
            .background(Color(.systemGray6)) // 연한 회색
            .cornerRadius(15)
            // 특정 상태(State)가 변경될 때 호출되는 클로저 onChange 이용
            .onChange(of: selectedIdx1) { idx in // 바인딩에 넣어줌
                sortType = sortedArr[idx] == "acc" ? "accuracy" : "recency"
            }
            
            Picker("페이지", selection: $selectedIdx2) {
                ForEach(pagesArr.indices, id: \.self) { i in
                    Text("\(pagesArr[i])")
                        .foregroundColor(.black)
                }
            }
            .pickerStyle(.menu)
            .background(Color(.systemGray6))
            .cornerRadius(15)
            .onChange(of: selectedIdx2) { idx in
                pageType = pagesArr[idx]
            }
            
            Picker("크기", selection: $selectedIdx3) {
                ForEach(sizeArr.indices, id: \.self) { i in
                    Text("\(sizeArr[i])")
                        .foregroundColor(.black)
                }
            }
            .pickerStyle(.menu)
            .background(Color(.systemGray6))
            .cornerRadius(15)
            .onChange(of: selectedIdx3) { idx in
                sizeType = sizeArr[idx]
            }
        }
                .padding(.horizontal) // 양 옆 간격 조정
    }
}
