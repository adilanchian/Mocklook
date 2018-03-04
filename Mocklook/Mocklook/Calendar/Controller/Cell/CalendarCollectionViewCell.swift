//
//  CalendarCollectionViewCell.swift
//  Mocklook
//
//  Created by Alec Dilanchian on 3/3/18.
//  Copyright © 2018 Alec Dilanchian. All rights reserved.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    //-- UI Properties --//
    let dayLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: screenSize.maxX / 7, height: screenSize.maxX / 7)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = textColor
        label.text = ""
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup all UI elements //
        self.setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //-- Helpers --//
    func setDayLabel(monthDayPath: IndexPath) {
        let currentMonth = Calendar.current.component(.month, from: Date())
        
        // All cells before/after current date should be grayed out //
        if monthDayPath.section + 1 != currentMonth {
            self.backgroundColor = disabledColor
        } else {
            self.backgroundColor = UIColor.white
        }
        
        // Text for collection view cell //
        var dayText = "\(monthDayPath.row + 1)"
        
        // If it is the first of the month, add the month string to the cell //
        if monthDayPath.row + 1 == 1 {
            let dateFormatter = DateFormatter().shortMonthSymbols
            let monthString = dateFormatter![monthDayPath.section]
            dayText = "\(monthString)\n\(monthDayPath.row + 1)"
        }
        
        self.dayLabel.text = dayText
    }
    
    func setupSubViews() {
        // Add border bottom for each cell //
        let borderBottom = CALayer()
        borderBottom.frame = CGRect(x: 0, y: self.frame.height - 1, width: self.frame.width, height: 1.0)
        borderBottom.backgroundColor = separatorColor.cgColor
        self.layer.addSublayer(borderBottom)
        
        self.addSubview(self.dayLabel)
    }
}
