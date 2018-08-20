//
//  DateFormatter.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/15/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import Foundation

enum DescriptionDate: String {
    case second = "SECONDS AGO"
    case min = "MINUTES AGO"
    case hour = "HOURS AGO"
    case day = "DAYS AGO"
    case week = "WEEKS AGO"
    case year = "YEARS AGO"
    func getDescription(value: Int) -> String {
        return "\(value) " + self.rawValue
    }
}

struct DateIntervals {
    static let minute = 60
    static let hour = 60 * DateIntervals.minute
    static let day = 24 * DateIntervals.hour
    static let week = 7 * DateIntervals.day
    static let year = 52 * DateIntervals.week
}

extension Date {
    
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        if secondsAgo < DateIntervals.minute {
            return DescriptionDate.second.getDescription(value: secondsAgo)
            
        } else if secondsAgo < DateIntervals.hour {
            return DescriptionDate.min.getDescription(value: secondsAgo/DateIntervals.minute)
            
        } else if secondsAgo < DateIntervals.day {
            return DescriptionDate.hour.getDescription(value: secondsAgo/DateIntervals.hour)
            
        } else if secondsAgo < DateIntervals.week {
            return DescriptionDate.day.getDescription(value: secondsAgo/DateIntervals.day)
            
        } else if secondsAgo < DateIntervals.year {
            return DescriptionDate.week.getDescription(value: secondsAgo/DateIntervals.week)
        } else {
            return DescriptionDate.year.getDescription(value: secondsAgo/DateIntervals.year)
        }
    }
}
