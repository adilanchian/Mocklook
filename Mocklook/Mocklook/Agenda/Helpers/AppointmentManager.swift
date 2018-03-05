//
//  AppointmentHandler.swift
//  Mocklook
//
//  Created by Alec Dilanchian on 3/4/18.
//  Copyright © 2018 Alec Dilanchian. All rights reserved.
//

import Foundation

class AppointmentManager {
    var appointments: [Appointment]!
    var randoAddresses: [String]!
    var randoTitles: [String]!
    var randoTime: [Date]!
    var randoMembers: [String]!
    var sortedAppointments: Dictionary<String, [Appointment]>!
    
    init() {
        self.appointments = [Appointment]()
        self.randoAddresses = [
            "991 Spring Lane Portsmouth, VA 23703",
            "202 Cooper St. Seymour, IN 47274",
            "2 W. Philmont Street Conyers, GA 30012",
            "88 Wayne Street Conway, SC 29526",
            "239 Spruce Street Evans, GA 30809"
        ]
        self.randoTitles = [
            "Laughing Willow",
            "The Wet Past",
            "Magic of Vision",
            "The Hunter's Sliver",
            "Someone in the Windows"
        ]
        self.randoTime = [Date]()
        self.randoMembers = [
            "Cora Mcguire",
            "Devin Mckenzie",
            "Megan Higgins",
            "Al Ball",
            "Tiffany Lucas"
        ]
        self.sortedAppointments = Dictionary<String, [Appointment]>()
    }
    
    //-- Helpers --//
    func generateAppointments() {
        for _ in 0...25 {
            let randomMonth = Int(arc4random_uniform(3))
            let randomValue = Int(arc4random_uniform(5))
            let dateComps = DateComponents.init(calendar: Calendar.current, timeZone: Calendar.current.timeZone, era: nil, year: 2018, month: randomMonth, day: (randomValue + 4), hour: (24 - randomValue), minute: (60 - randomValue), second: nil, nanosecond: nil, weekday: randomValue, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil)
            
            let appointment = Appointment(title: self.randoTitles[randomValue], location: self.randoAddresses[randomValue], dateTime: Calendar.current.date(from: dateComps)!, members: self.randoMembers)
            self.appointments.append(appointment)
        }
    }
    
    func sortAppointments() {
        self.appointments.forEach { (appointment) in
            // Create date string key //
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE, MMMM d"
            
            // Create date key that associates with tableview section //
            let dateKey = formatter.string(from: appointment.dateTime)
            
            // Check to see if appointment key exists in dictionary//
            if self.sortedAppointments.keys.contains(dateKey) {
                // Insert new value into date array for key //
                var currentDates = self.sortedAppointments[dateKey]
                currentDates!.append(appointment)
                self.sortedAppointments[dateKey] = currentDates
            } else {
                self.sortedAppointments[dateKey] = [appointment]
            }
        }
        
        self.sortedAppointments.forEach { (key, dateArray) in
            print("\(key) ---> \(dateArray)")
        }
    }
}
