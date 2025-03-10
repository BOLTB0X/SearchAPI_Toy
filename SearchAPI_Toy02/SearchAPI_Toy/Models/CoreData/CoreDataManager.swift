//
//  CoreDataManager.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/20.
//

import Foundation
import CoreData

// MARK: - CoreDataManager
class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() { }
    
    // MARK: - searchContainer
    lazy var searchContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SearchModel")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - saveSearchHistory
    // 검색 기록으로 coreData에 넣어주는 역할
    func saveSearchHistory(query: String, date: Date) {
        let context = searchContainer.viewContext
        
        // 기존에 저장된 검색 기록을 확인
        let fetchRequest: NSFetchRequest<SearchHistory> = SearchHistory.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "query == %@", query)
        
        // 이미 검색한 기록이 있으면
        if let OgSearch = try? context.fetch(fetchRequest).first {
            OgSearch.date = date
        } else {
            // 없어서 추가
            let entity = NSEntityDescription.entity(forEntityName: "SearchHistory", in: context)!
            let newSearchHistory = NSManagedObject(entity: entity, insertInto: context) as! SearchHistory
            newSearchHistory.query = query
            newSearchHistory.date = date
        }
        
        do {
            try context.save()
        } catch {
            print("실패: \(error)")
        }
    }
    
    // MARK: - deleteSearchHistoy
    // 검색 기록 삭제
    func deleteSearchHistory(searchHistory: SearchHistory) {
        let context = searchContainer.viewContext
        context.delete(searchHistory)
        
        do {
            try context.save()
        } catch {
            print("삭제 실패: \(error)")
        }
    }
}
