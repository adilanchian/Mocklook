//
//  Appointment.swift
//  Mocklook
//
//  Created by Alec Dilanchian on 3/4/18.
//  Copyright © 2018 Alec Dilanchian. All rights reserved.
//

/*
    This is the appointment class that is used to handle the layout of an appointment
    and manipulate them in any way necessary. This is also where we bring in the SwiftSky
    framework to get the real time temperature for each appointment location.
*/

import Foundation
import SwiftSky

class Appointment {
    //-- Properties --//
    public var title: String!
    public var location: String!
    public var dateTime: Date!
    public var members: [String]!
    public var available: Bool!
    public var duration: String!
    public var temperature: String!
    public var localizedTime: String {
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
        SwiftSky.secret = Constants.APIKeys.swiftSkyKey
        SwiftSky.language = .english
        SwiftSky.locale = .autoupdatingCurrent
        SwiftSky.units.temperature = .fahrenheit
    }
    
    public func getTemperature() {
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
                    self.temperature = forecast.current!.temperature!.current!.label
                case .failure(let error):
                    print("There was an error getting the temperature: \(error)")
                    self.temperature = "Temp N/a"
                }
            })
        }
    }
}
