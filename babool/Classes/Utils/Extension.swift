//
//  Extension.swift
//  Babool
//
//  Created by Abhishek Kumar Ravi on 25/05/25.
//

import Foundation

extension TimeInterval {
    /// Converts a UNIX timestamp (TimeInterval) to a formatted date string
    func formattedDateString(format: String = "yyyy-MM-dd HH:mm:ss", timeZone: TimeZone = .current) -> String {
        let date = Date(timeIntervalSince1970: self)
        return date.formattedString(format: format, timeZone: timeZone)
    }
}

extension Date {
    /// Converts a Date to a formatted string
    func formattedString(format: String = "yyyy-MM-dd HH:mm:ss", timeZone: TimeZone = .current) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = timeZone
        return formatter.string(from: self)
    }
}
