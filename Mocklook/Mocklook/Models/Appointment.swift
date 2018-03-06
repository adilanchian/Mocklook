//
//  Appointment.swift
//  Mocklook
//
//  Created by Alec Dilanchian on 3/4/18.
//  Copyright © 2018 Alec Dilanchian. All rights reserved.
//

import Foundation
import SwiftSky

class Appointment {
    //-- Properties --//
    var title: String!
    var location: String!
    var dateTime: Date!
    var members: [String]!
    var available: Bool!
    var duration: String!
    var temperature: String!
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
        self.temperature = nil
        
        // Setup SwiftSky framework //
        SwiftSky.secret = swiftSkyKey
        SwiftSky.language = .english
        SwiftSky.locale = .autoupdatingCurrent
        SwiftSky.units.temperature = .fahrenheit
    }
    
    func getTemperature() {
        let geoLocator = GeoLocatorManager()
        
        geoLocator.getCoordinates(address: self.location) { (location) in
            guard let coordinates = location else {
                print("Location came back nil. Returning.")
                self.temperature = "Temp N/a"
                return
            }
            
            // Call SwiftSky API //
            SwiftSky.get([.current], at: coordinates, { (result) in
                switch result {
                case .success(let forecast):
                    print(forecast.current!.temperature!.current!.label)
                    self.temperature = forecast.current!.temperature!.current!.label
                case .failure(let error):
                    print("There was an error getting the temperature: \(error)")
                    self.temperature = "Temp N/a"
                }
            })
        }
    }
}
