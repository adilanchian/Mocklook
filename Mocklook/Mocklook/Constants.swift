//
//  File.swift
//  Mocklook
//
//  Created by Alec Dilanchian on 3/3/18.
//  Copyright © 2018 Alec Dilanchian. All rights reserved.
//

/*
    This swift file is a spot to hold all constant properties that will be used throughout
    the app.
*/

import Foundation
import UIKit

//-- Colors --//
let grayTextColor = UIColor(red:0.55, green:0.55, blue:0.57, alpha:1.0)
let disabledColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.0)
let separatorColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0)
let todaySectionBgColor = UIColor(red:0.96, green:0.98, blue:0.99, alpha:1.0)
let todaySectionTxtColor = UIColor(red:0.00, green:0.46, blue:0.78, alpha:1.0)
let availIndicatorColor = UIColor(red:0.18, green:0.80, blue:0.44, alpha:1.0)
let pendingIndicatorColor = UIColor(red:0.90, green:0.49, blue:0.13, alpha:1.0)
let calenderSelectedColor = UIColor(red:0.00, green:0.47, blue:0.85, alpha:0.5)

//-- Device Screen Size --//
let screenSize = UIScreen.main.bounds
let statusBarSize = UIApplication.shared.statusBarFrame

//-- SwiftSky API Key --//
// PLEASE NOTE: I do realize the large security breach that is happening here, but given the timeframe, this was the best approach in my mind. Ultimately, reading this key in from a config file would be ideal //
let swiftSkyKey = "25323cb3ad985eae919f806cd2949e55"
