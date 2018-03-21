//
//  Extensions.swift
//  Mocklook
//
//  Created by Alec Dilanchian on 3/20/18.
//  Copyright © 2018 Alec Dilanchian. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func animateResize(duration: TimeInterval, newSize: CGRect) {
        UIView.animate(withDuration: duration) {
            self.frame = newSize
        }
    }
}
