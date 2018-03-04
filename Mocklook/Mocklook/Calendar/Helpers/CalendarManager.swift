//
//  DateManager.swift
//  Mocklook
//
//  Created by Alec Dilanchian on 3/3/18.
//  Copyright © 2018 Alec Dilanchian. All rights reserved.
//

import Foundation

class CalendarManager {
    //-- Properties --//
    var calendar = Calendar.current
    var currentYear: Int!
    var currentMonth: Int!
    var currentWeek: Int!
    var currentWeekDay: Int!
    var currentDay: Int!
    
    init() {
        let date = Date()
        self.currentYear = calendar.component(.year, from: date)
        self.currentMonth = calendar.component(.month, from: date)
        self.currentWeek = calendar.component(.weekOfMonth, from: date)
        self.currentWeekDay = calendar.component(.weekday, from: date)
        self.currentDay = calendar.component(.day, from: date)
    }
    
    //-- Helpers --//
    func numDaysByMonth(month: Int) -> Int {
        // We should get the number of week days in each month and return //
        let sectionDateComps = DateComponents.init(calendar: self.calendar, timeZone: self.calendar.timeZone, era: nil, year: self.currentYear, month: month, day: nil, hour: nil, minute: nil, second: nil, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil)
        let sectionDate = self.calendar.date(from: sectionDateComps)
        
        guard let range = self.calendar.range(of: .day, in: .month, for: sectionDate!) else {
            print("Could not find number days for month section \(month).")
            return 0
        }
        
        return range.count
    }
}
