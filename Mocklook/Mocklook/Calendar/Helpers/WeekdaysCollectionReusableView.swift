//
//  SectionCollectionReusableView.swift
//  Mocklook
//
//  Created by Alec Dilanchian on 3/3/18.
//  Copyright © 2018 Alec Dilanchian. All rights reserved.
//

import UIKit

class WeekdaysCollectionReusableView: UICollectionReusableView {
    var container: UIView!
    var stackContainer: UIStackView!
    var labelArray: [UILabel]!
    let weekdays = ["S", "M", "T", "W", "T", "F", "S"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.container = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.maxX, height: screenSize.maxX / 7))
        self.labelArray = [UILabel]()
        
        for index in 0...self.weekdays.count - 1 {
            let dayLabel = UILabel()
            // dayLabel.frame = CGRect(x: 0, y: 0, width: screenSize.maxX / 7, height: screenSize.maxX / 7)
            dayLabel.textAlignment = .center
            dayLabel.font = UIFont.systemFont(ofSize: 16)
            dayLabel.textColor = grayTextColor
            dayLabel.text = weekdays[index]
            self.labelArray.append(dayLabel)
        }
        
        self.stackContainer = UIStackView(arrangedSubviews: self.labelArray)
        self.stackContainer.backgroundColor = UIColor.green
        self.stackContainer.axis = .horizontal
        self.stackContainer.alignment = .fill
        self.stackContainer.distribution = .fillEqually
        self.stackContainer.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.stackContainer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
