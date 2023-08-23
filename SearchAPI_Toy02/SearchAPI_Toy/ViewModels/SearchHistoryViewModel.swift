//
//  SearchHistoryViewModel.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/20.
//

import Foundation
import CoreData

// MARK: - SearchHistoryViewModel
// 검색 기록을 관리하는 뷰모델
class SearchHistoryViewModel: ObservableObject {
    @Published var searchHistory: [SearchHistory] = [] // 검색 기록, 여긴 코어 데이터명이 아닌 엔티티명
    
    init() {
        fetchSearchHistory()
    }
    
    // MARK: - fetchSearchHistory
    func fetchSearchHistory() {
        let fetchRequest: NSFetchRequest<SearchHistory> = SearchHistory.fetchRequest()
        
        do {
            let context = CoreDataManager.shared.searchContainer.viewContext
            searchHistory = try context.fetch(fetchRequest).sorted { $0.date! > $1.date! } // 불러오기 및 정렬
        } catch {
            print("불러오기 실패")
        }
    }
}
