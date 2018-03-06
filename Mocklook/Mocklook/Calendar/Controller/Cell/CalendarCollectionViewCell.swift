//
//  CalendarCollectionViewCell.swift
//  Mocklook
//
//  Created by Alec Dilanchian on 3/3/18.
//  Copyright © 2018 Alec Dilanchian. All rights reserved.
//

/*
    This is the class for the calendar cells. This holds any and all logic for each cell.
    It also implements "prepareForReuse" so any recyled cells do not have old data.
*/

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    //-- UI Properties --//
    let dayLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: screenSize.width / 7, height: screenSize.width / 7)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = grayTextColor
        label.text = nil
        return label
    }()
    var isDisabled: Bool!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup all UI elements //
        self.addSubViews()
    }
    
    override func prepareForReuse() {
        self.dayLabel.textColor = grayTextColor
        self.dayLabel.text = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //-- Helpers --//
    func addSubViews() {
        // Add border bottom for each cell //
        let borderBottom = CALayer()
        borderBottom.frame = CGRect(x: 0, y: self.frame.height - 1, width: self.frame.width, height: 1.0)
        borderBottom.backgroundColor = separatorColor.cgColor
        self.layer.addSublayer(borderBottom)
        
        self.addSubview(self.dayLabel)
    }
    
    func setDayLabel(monthDayPath: IndexPath) {
        let currentMonth = Calendar.current.component(.month, from: Date())
        
        // All cells before/after current date should be grayed out //
        if monthDayPath.section + 1 != currentMonth {
            self.backgroundColor = disabledColor
            self.isDisabled = true
        } else {
            self.isDisabled = false
            self.backgroundColor = UIColor.white
        }
        
        // Text for collection view cell. +1 because row returns on index //
        var dayText = "\(monthDayPath.row + 1)"
        
        // If it is the first of the month, add the month string to the cell //
        if monthDayPath.row + 1 == 1 {
            let dateFormatter = DateFormatter().shortMonthSymbols
            let monthString = dateFormatter![monthDayPath.section]
            dayText = "\(monthString)\n\(monthDayPath.row + 1)"
        }
        
        self.dayLabel.text = dayText
    }
    
    func selectCell() {
        self.backgroundColor = calenderSelectedColor
        self.dayLabel.textColor = UIColor.white
    }
    
    func deselectCell() {
        // If cell was orignally disabled, make sure to gray it out //
        if self.isDisabled {
            self.backgroundColor = disabledColor
        } else {
            self.backgroundColor = UIColor.white
        }
        
        self.dayLabel.textColor = grayTextColor
    }
}
