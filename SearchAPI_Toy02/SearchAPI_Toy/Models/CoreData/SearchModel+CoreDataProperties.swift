//
//  SearchHistory+CoreDataProperties.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/20.
//
//

import Foundation
import CoreData


extension SearchModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SearchModel> {
        return NSFetchRequest<SearchModel>(entityName: "SearchHistory")
    }

    @NSManaged public var query: String?
    @NSManaged public var date: Date?

}

extension SearchModel : Identifiable {

}
