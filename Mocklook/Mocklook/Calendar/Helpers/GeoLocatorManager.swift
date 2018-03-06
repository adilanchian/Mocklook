//
//  GeoLocatorManager.swift
//  Mocklook
//
//  Created by Alec Dilanchian on 3/5/18.
//  Copyright © 2018 Alec Dilanchian. All rights reserved.
//

/*
    This class handles the coordinate fetching of each appointment location that is created.
    This also prepares a CLLocation object to be ingested by the Forecasting API.
*/

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
