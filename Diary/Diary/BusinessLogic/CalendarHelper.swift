//
//  CalendarHelper.swift
//  Diary
//
//  Created by Konstantin Pimbursky on 06.03.2022.
//

import UIKit

final class CalendarHelper {
    
    // MARK: - Private Properties
    
    private let calendar = Calendar.current
    
    // MARK: - Public Methods
    
    public func plusMonth(date: Date) -> Date {
        guard
            let newDate = calendar.date(byAdding: .month, value: 1, to: date)
        else { return Date() }
        return newDate
    }
    
    public func minusMonth(date: Date) -> Date {
        guard
            let newDate = calendar.date(byAdding: .month, value: -1, to: date)
        else { return Date() }
        return newDate
    }
    
    public func monthString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMM yyyy")
        return dateFormatter.string(from: date)
    }
    
    public func daysInMonth(date: Date) -> Int {
        guard let range = calendar.range(of: .day, in: .month, for: date) else { return 0 }
        return range.count
    }
    
    public func dayOfMonth(date: Date) -> Int {
        guard let dayOfMonth = calendar.dateComponents([.day], from: date).day else { return 1 }
        return dayOfMonth
    }
    
    public func firstOfMonth(date: Date) -> Date {
        let firstDateComponents = calendar.dateComponents([.year, .month], from: date)
        guard let firstDate = calendar.date(from: firstDateComponents) else { return Date() }
        return firstDate
    }
    
    public func weekDay(date: Date) -> Int {
        guard let weekDay = calendar.dateComponents([.weekday], from: date).weekday else { return 1 }
        return weekDay - 2
    }
}
