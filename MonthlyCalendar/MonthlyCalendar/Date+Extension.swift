//
//  Date+Extension.swift
//  MonthlyCalendar
//
//  Created by Eunbin Kwon on 2022/04/10.
//

import Foundation

extension Date {
    var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        return formatter
    }
    
    var dotFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }
    
    var dateComponents: DateComponents {
        Calendar.current.dateComponents([.day, .month, .year], from: self)
    }
    
    var year: Int {
        self.dateComponents.year ?? -1
    }
    
    var month: Int {
        self.dateComponents.month ?? -1
    }
    
    var day: Int {
        self.dateComponents.day ?? -1
    }
    
    var isToday: Bool {
        let today = self.formatter.string(from: Date())
        let selectedDate = self.formatter.string(from: self)
        return today == selectedDate
    }
    
    var formattedString: String {
        self.dotFormatter.string(from: self)
    }
    
    func allDates() -> [Date] {
        guard let startDate = Calendar.current.date(
            from: Calendar.current.dateComponents(
                [.year, .month],
                from: self
            )
        ) else { return [] }
        
        guard let range = Calendar.current.range(of: .day, in: .month, for: startDate)
        else { return [] }
        
        return range.compactMap{ day -> Date in
            return Calendar.current.date(
                byAdding: .day,
                value: day - 1 ,
                to: startDate
            ) ?? Date()
        }
    }
    
    func isSameAs(date: Date) -> Bool {
        Calendar.current.isDate(self, inSameDayAs: date)
    }
}
