//
//  MocklookTests.swift
//  MocklookTests
//
//  Created by Alec Dilanchian on 3/3/18.
//  Copyright © 2018 Alec Dilanchian. All rights reserved.
//

import XCTest

class MocklookTests: XCTestCase {
    //-- Properties: Calendar Manager --//
    let calendarManager = CalendarManager()
    let stringDate = "Monday, March 5"
    let dayPath = IndexPath(row: 20, section: 11) // 12/19/2018
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //-- Calendar Manager Tests --//
    func testCalendarManager_numDaysByMonth() {
        print("Testing numDaysByMonth...")
        
        let numDays = calendarManager.numDaysByMonth(month: calendarManager.calendar.component(.month, from: Date()))
        
        print("[numDaysByMonthTest] numDays: \(numDays)")
        
        guard let numDaysTest = Calendar.current.range(of: .day, in: .month, for: Date()) else {
            print("[numDaysByMonthTest] Failed. numDaysTest was nil.")
            assert(false)
        }
        
        print("[numDaysByMonthTest] numDaysTest: \(numDaysTest.count)")
        
        if numDays == numDaysTest.count {
            print("[numDaysByMonthTest] Passed!")
            assert(true)
        }
    }
    
    func testCalendarManager_getEachDayForYear() {
        print("Testing getEachDayForYear...")
        
        self.calendarManager.getEachDayForYear()
        
        // There should be 365 section for the year of 2018 //
        if self.calendarManager.sectionDays.count == 365 {
            print("[getEachDayForYear] Passed!")
            assert(true)
        } else {
            print("[getEachDayForYear] Failed. Count: \(self.calendarManager.sectionDays.count)")
            assert(false)
        }
    }
    
    func testCalendarManager_calculateCalendarPath() {
        print("Testing calculateCalendarPath...")
        
        guard let path = self.calendarManager.calculateCalendarPath(stringDate: self.stringDate) else {
            print("[calculateCalendarPath] Failed. Invalid date.")
            assert(false)
        }
        
        if path == IndexPath(row: 4, section: 2) {
            print("[calculateCalendarPath] Passed!")
            assert(true)
        } else {
            print("[calculateCalendarPath] Failed. IndexPath: \(path).")
            assert(false)
        }
    }
    
    func testCalendarManager_calculateAgendaPath() {
        print("Testing calculateAgendaPath...")
        
        let path = self.calendarManager.calculateAgendaPath(dayPath: dayPath)
        
        if path == IndexPath(row: 0, section: 354) {
            print("[calculateAgendaPath] Passed!")
            assert(true)
        } else {
            print("[calculateAgendaPath] Failed. IndexPath: \(path).")
            assert(false)
        }
    }
}
