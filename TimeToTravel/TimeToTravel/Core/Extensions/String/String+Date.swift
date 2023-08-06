//
//  String+Date.swift
//  TimeToTravel
//
//  Created by George Weaver on 01.08.2023.
//

import UIKit

extension String {
    
    func getDayAndMonth() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZ 'UTC'"
        if let date = dateFormatter.date(from: self) {
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "d MMM, EEE"
            outputDateFormatter.locale = Locale(identifier: "ru")
            return outputDateFormatter.string(from: date)
        } else {
            return nil
        }
    }
}
