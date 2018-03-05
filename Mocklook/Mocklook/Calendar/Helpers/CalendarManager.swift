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
    var sectionDays: [String]!
    var currentDate: Date {
        get {
            let components = DateComponents(calendar: self.calendar, timeZone: self.calendar.timeZone, era: nil, year: self.currentYear, month: self.currentMonth, day: self.currentDay, hour: nil, minute: nil, second: nil, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil)
            
            return self.calendar.date(from: components)!
        }
    }
    var todayDateSection: Int {
        get {
            let startDateComps = DateComponents(calendar: self.calendar, timeZone: self.calendar.timeZone, era: nil, year: self.currentYear, month: 1, day: 1, hour: nil, minute: nil, second: nil, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil)
            let startDay = self.calendar.date(from: startDateComps)
            let endDate = Date()
            
            return self.calendar.dateComponents([.day], from: startDay!, to: endDate).day!
        }
    }
    
    init() {
        let date = Date()
        self.currentYear = calendar.component(.year, from: date)
        self.currentMonth = calendar.component(.month, from: date)
        self.currentWeek = calendar.component(.weekOfMonth, from: date)
        self.currentWeekDay = calendar.component(.weekday, from: date)
        self.currentDay = calendar.component(.day, from: date)
        self.sectionDays = [String]()
    }
    
    //-- Helpers --//
    func numDaysByMonth(month: Int) -> Int {
        // We should get the number of week days in each month and return //
        let sectionDateComps = DateComponents(calendar: self.calendar, timeZone: self.calendar.timeZone, era: nil, year: self.currentYear, month: month, day: nil, hour: nil, minute: nil, second: nil, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil)
        let sectionDate = self.calendar.date(from: sectionDateComps)
        
        guard let range = self.calendar.range(of: .day, in: .month, for: sectionDate!) else {
            print("Could not find number days for month section \(month).")
            return 0
        }
        
        return range.count
    }
    
    func getEachDayForYear() {
        // This should start from the first day of the year and return an array of strings of each day //
        // Create start date object for Jan 1 of current year //
        let startDateComps = DateComponents(calendar: self.calendar, timeZone: self.calendar.timeZone, era: nil, year: self.currentYear, month: 1, day: 1, hour: nil, minute: nil, second: nil, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil)
        var day = self.calendar.date(from: startDateComps)
        let endDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d"
        
        while day! <= endDate {
            if self.currentDate == day! {
                self.sectionDays.append("Today · "+formatter.string(from: day!))
            } else {
                self.sectionDays.append(formatter.string(from: day!))
            }
            
            day = calendar.date(byAdding: .day, value: 1, to: day!)
        }
    }
}
