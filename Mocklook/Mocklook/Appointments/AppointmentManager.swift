//
//  AppointmentHandler.swift
//  Mocklook
//
//  Created by Alec Dilanchian on 3/4/18.
//  Copyright © 2018 Alec Dilanchian. All rights reserved.
//

/*
    This class is the appointment handles anything to do with appointments. It creates mock
    data that is randomized for a set array. DISCLAIMER: all addresses were pulled from a random address generator, except the Microsoft address.
*/

import Foundation

class AppointmentManager {
    //-- Properties --//
    fileprivate let appointments = AppointmentDataSource().sortedAppointments
    
    //-- Helpers --//
    public func getAppointmentsCount(sectionName: String) -> Int {
        if (self.appointments?.keys.contains(sectionName))! {
            return self.appointments![sectionName]!.count
        }
        
        return 0
    }
    
    public func getAppointment(sectionName: String, currentAppointment: Int) -> Appointment? {
        // Get the key from dictionary //
        if (self.appointments?.keys.contains(sectionName))! {
            let sectionAppointments = self.appointments![sectionName]!
            return sectionAppointments[currentAppointment]
        }
        
        return nil
    }
    
    public func hasAppointmentsForSection(sectionName: String) -> Bool {
        if (self.appointments?.keys.contains(sectionName))! {
            return true
        }
        
        return false
    }
}
