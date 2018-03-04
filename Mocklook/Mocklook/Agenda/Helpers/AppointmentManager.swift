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
    
    init() {
        self.appointments = [Appointment]()
    }
    
    //-- Helpers --//
    func generateAppointments() {
        for index in 0...25 {
            let appointment = Appointment(title: "Appointment #\(index)", location: "123 Main Street, New York City NY, 99999", dateTime: Date(), members: ["Alec", "Bob", "Daniela", "Avery"])
            self.appointments.append(appointment)
        }
    }
    
//    func appointmentCount() -> Dictionary<Date, Int> {
//
//    }
}
