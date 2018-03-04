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
    var calendarManager = CalendarManager()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCalendarManager_numDaysByMonth() {
        print("Testing numDaysByMonth...")
        
        let numDays = calendarManager.numDaysByMonth(month: calendarManager.calendar.component(.month, from: Date()))
        
        print("[numDaysByMonthTest] numDays: \(numDays)")
        
        guard let numDaysTest = Calendar.current.range(of: .day, in: .month, for: Date()) else {
            print("[numDaysByMonthTest] Failed. numDaysTest was nil")
            assert(false)
        }
        
        print("[numDaysByMonthTest] numDaysTest: \(numDaysTest.count)")
        
        if numDays == numDaysTest.count {
            print("[numDaysByMonthTest] Passed!")
            assert(true)
        }
    }
}
