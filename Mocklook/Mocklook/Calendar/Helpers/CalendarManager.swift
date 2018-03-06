//
//  DateManager.swift
//  Mocklook
//
//  Created by Alec Dilanchian on 3/3/18.
//  Copyright © 2018 Alec Dilanchian. All rights reserved.
//

/*
    This class holds all the logic for dealing with calendar events such as getting current days,
    making sure IndexPaths are converted properly, and much more!
*/

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
        // Setting up a component to get the current Date object via components //
        get {
            let components = DateComponents(calendar: self.calendar, timeZone: self.calendar.timeZone, era: nil, year: self.currentYear, month: self.currentMonth, day: self.currentDay, hour: nil, minute: nil, second: nil, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil)
            
            return self.calendar.date(from: components)!
        }
    }
    var todayDateSection: Int {
        // Get the current number of days in the current month //
        get {
            let startDateComps = DateComponents(calendar: self.calendar, timeZone: self.calendar.timeZone, era: nil, year: self.currentYear, month: 1, day: 1, hour: nil, minute: nil, second: nil, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil)
            let startDay = self.calendar.date(from: startDateComps)
            let endDate = Date()
            
            return self.calendar.dateComponents([.day], from: startDay!, to: endDate).day!
        }
    }
    
    var friendlyMonth: String {
        // Return a string that can be used in the UI //
        get {
            let formatter = DateFormatter()
            // We subtract 1 because we need the index of the monthSymbols //
            return formatter.monthSymbols[self.currentMonth - 1]
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
        
        // Create end date object of current year //
        let endDateComps = DateComponents(calendar: self.calendar, timeZone: self.calendar.timeZone, era: nil, year: self.currentYear, month: 12, day: 31, hour: nil, minute: nil, second: nil, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil)
        let endDate = self.calendar.date(from: endDateComps)
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d"
        
        while day! <= endDate! {
            if self.currentDate == day! {
                self.sectionDays.append("Today · "+formatter.string(from: day!))
            } else {
                self.sectionDays.append(formatter.string(from: day!))
            }
            
            day = calendar.date(byAdding: .day, value: 1, to: day!)
        }
    }
    
    // This helper function returns an IndexPath, for the calendar to ingest, based on the current agenda selection //
    func calculateCalendarPath(stringDate: String) -> IndexPath? {
        // Create Date object from string //
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d"

        guard let date = formatter.date(from: stringDate) else {
            print("Invalid date. Returning.")
            return nil
        }
        
        // Get month component //
        let monthIndex = self.calendar.component(.month, from: date) - 1
        
        // Get day component //
        let dayIndex = self.calendar.component(.day, from: date) - 1
        
        // Create IndexPath //
        return IndexPath(item: dayIndex, section: monthIndex)
    }
    
    // This helper function returns an IndexPath, for the agenda to ingest, based on the current calendar selection //
    func calculateAgendaPath(dayPath: IndexPath) -> IndexPath {
        var numDays = 0
        
        // Get num days in month //
        if dayPath.section == 0 {
            return IndexPath(row: 0, section: dayPath.row)
        } else {
            for index in 1...dayPath.section {
                numDays = numDays + self.numDaysByMonth(month: index)
            }
        }
        
        // Get num days in month and then add day //
        let daySection = numDays + dayPath.row
        
        // Return path for agenda view //
        return IndexPath(row: 0, section: daySection)
    }
}
