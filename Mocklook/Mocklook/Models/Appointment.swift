//
//  Appointment.swift
//  Mocklook
//
//  Created by Alec Dilanchian on 3/4/18.
//  Copyright © 2018 Alec Dilanchian. All rights reserved.
//

import Foundation

class Appointment {
    //-- Properties --//
    var title: String!
    var location: String!
    var dateTime: Date!
    var members: [String]!
    var available: Bool!
    var duration: String!
    var localizedTime: String {
        get {
            let formatter = DateFormatter()
            formatter.dateFormat = "h:mm a"
            return "\(formatter.string(from: self.dateTime))"
        }
    }
    
    init(title: String, location: String, dateTime: Date, members: [String], duration: String) {
        self.title = title
        self.location = location
        self.dateTime = dateTime
        self.members = members
        self.available = true
        self.duration = duration
    }
}
