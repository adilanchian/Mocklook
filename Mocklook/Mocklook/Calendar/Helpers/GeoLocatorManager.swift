//
//  GeoLocatorManager.swift
//  Mocklook
//
//  Created by Alec Dilanchian on 3/5/18.
//  Copyright © 2018 Alec Dilanchian. All rights reserved.
//

import Foundation
import CoreLocation

class GeoLocatorManager {
    var geoLocator: CLGeocoder!
    
    init() {
        self.geoLocator = CLGeocoder()
    }
    
    //-- Helpers --//
    func getCoordinates(address: String, didGetLocation: @escaping (_ location: CLLocation?) -> ()) {
        self.geoLocator.geocodeAddressString(address) { (placemarks, error) in
            if error != nil {
                print("Error getting coordinates: \(error!)")
                didGetLocation(nil)
                return
            }
            
            guard let location = placemarks!.first?.location else {
                print("There were no locations found.")
                didGetLocation(nil)
                return
            }
            
            didGetLocation(location)
        }
    }
}
