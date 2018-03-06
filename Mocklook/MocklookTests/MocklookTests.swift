//
//  MocklookTests.swift
//  MocklookTests
//
//  Created by Alec Dilanchian on 3/3/18.
//  Copyright © 2018 Alec Dilanchian. All rights reserved.
//

/*
    Here we have the unit tests for Mocklook. I have added what I felt was the most important tests.
*/

import XCTest

class MocklookTests: XCTestCase {
    //-- Properties: Calendar Manager --//
    let calendarManager = CalendarManager()
    let stringDate = "Monday, March 5"
    let dayPath = IndexPath(row: 20, section: 11) // 12/19/2018
    
    //-- Properties: Appointment Manager --//
    let appointmenetManager = AppointmentManager()
    
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
    
    //-- Appointment Manager Tests --//
    func testAppointmentManager_generateAppointments() {
        print("Testing generateAppointments...")
        
        // Generate appointments //
        self.appointmenetManager.generateAppointments()
        
        // Verify each appointment does not have any nil values //
        self.appointmenetManager.appointments.forEach { (appointment) in
            if appointment.title == nil {
                print("[generateAppointments] Failed. Title was nil.")
                assert(false)
            }
            
            if appointment.location == nil {
                print("[generateAppointments] Failed. Location was nil.")
                assert(false)
            }
            
            if appointment.dateTime == nil {
                print("[generateAppointments] Failed. DateTime was nil.")
                assert(false)
            }
            
            if appointment.members == nil {
                print("[generateAppointments] Failed. Members was nil.")
                assert(false)
            }
            
            if appointment.duration == nil {
                print("[generateAppointments] Failed. Duration was nil.")
                assert(false)
            }
            
            if appointment.available == nil {
                print("[generateAppointments] Failed. Available was nil.")
                assert(false)
            }
        }
        
        // Verify there are 50 appointments //
        if self.appointmenetManager.appointments.count == 52 {
            print("[generateAppointments] Passed!")
            assert(true)
        } else {
            print("[generateAppointments] Failed. Num of appointments: \(self.appointmenetManager.appointments.count).")
            assert(false)
        }
    }
}
