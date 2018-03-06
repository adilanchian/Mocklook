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
    var randoDurations: [String]!
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
        self.randoDurations = [
            "15m",
            "30m",
            "45m",
            "1h",
            "112d 19h"
        ]
        self.sortedAppointments = Dictionary<String, [Appointment]>()
    }
    
    //-- Helpers --//
    func generateAppointments() {
        DispatchQueue.global(qos: .background).sync {
            for _ in 0...50 {
                // Properties to randomize appointments //
                let randomValue = Int(arc4random_uniform(5))
                let randomMonth = Int(arc4random_uniform(12))
                let currentMonth = Calendar.current.component(.month, from: Date())
                let currentDay = Calendar.current.component(.day, from: Date())
                let currentHour = Calendar.current.component(.hour, from: Date())
                let currentMinute = Calendar.current.component(.minute, from: Date())
                
                let dateComps = DateComponents.init(calendar: Calendar.current, timeZone: Calendar.current.timeZone, era: nil, year: 2018, month: abs(randomMonth - currentMonth + randomValue), day: abs(randomMonth + currentDay), hour: (24 - currentHour + randomValue), minute: (60 - currentMinute + randomValue), second: nil, nanosecond: nil, weekday: randomValue, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil)
                
                let appointment = Appointment(title: self.randoTitles[randomValue], location: self.randoAddresses[randomValue], dateTime: Calendar.current.date(from: dateComps)!, members: self.randoMembers, duration: self.randoDurations[randomValue])
                
                // Set indicator to true or false //
                if randomValue % 2 == 0 {
                    appointment.available = true
                } else {
                    appointment.available = false
                }
                
                self.appointments.append(appointment)
            }
            
            // Custom appointment //
            let customApt = Appointment(title: "Welcome Alec to Outlook!", location: "1 Microsoft Way, Redmond, WA 98052", dateTime: Date(), members: ["Alec", "Alon"], duration: "All day")
            customApt.available = true
            
            self.appointments.append(customApt)
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
            let sorted = dateArray.sorted(by: { (appt1, appt2) -> Bool in
                return appt1.dateTime.compare(appt2.dateTime) == .orderedAscending
            })
            self.sortedAppointments[key] = sorted
        }
    }
}
