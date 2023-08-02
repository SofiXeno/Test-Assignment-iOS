//
//  Date + timestamp.swift
//  Test-Assignment-iOS
//
//  Created by Sofia Ksenofontova on 02.08.2023.
//

import Foundation

extension Date {
    
    var currentWithTimeZone: Date {
        let timeZone = TimeZone.current
        let secondsFromGMT = timeZone.secondsFromGMT()
        return addingTimeInterval(TimeInterval(secondsFromGMT))
    }
    
    var timeIntervalSinceNowInCurrentTimezone: TimeInterval {
         let currentDateInTimezone = Date().currentWithTimeZone
         return timeIntervalSince(currentDateInTimezone)
     }
    
    
}
