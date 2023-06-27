//
//  Extension+String.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/08.
//

import Foundation

extension String {
    // MARK: - stripHTMLTags: HTML 테그 정리
    func stripHTMLTags() -> String {
        let regex = try? NSRegularExpression(pattern: "<[^>]+>|&quot;|<b>|</b>", options: .caseInsensitive)
        let range = NSRange(location: 0, length: self.count)
        return regex?.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "") ?? self
    }
    
    // MARK: - formatDateTime: 날짜표기 변경
    func fomatDateTime() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale (identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let date = dateFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.locale = Locale(identifier: "ko_KR")
            outputFormatter.dateFormat = "yyyy년 MM월 dd일 a HH시 mm분"
            
            return outputFormatter.string(from: date)
        }
        return nil
    }
}

