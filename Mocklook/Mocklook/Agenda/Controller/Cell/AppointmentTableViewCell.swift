//
//  AppointmentTableViewCell.swift
//  Mocklook
//
//  Created by Alec Dilanchian on 3/4/18.
//  Copyright © 2018 Alec Dilanchian. All rights reserved.
//

import UIKit

class AppointmentTableViewCell: UITableViewCell {
    //-- UI Properties --//
    var titleLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = nil
        return label
    }()
    
    var locationLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = grayTextColor
        label.text = nil
        return label
    }()
    
    var dateTimeLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = nil
        return label
    }()
    
    var noEventsLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = grayTextColor
        label.text = nil
        return label
    }()
    
    var availabilityIndicator: UIView = {
        let view = UIView()
        view.tag = 1
        view.frame = CGRect(x: 0, y: 0, width: 12, height: 12)
        view.layer.cornerRadius = 6.0
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Add labels to cell //
        self.addSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        let subviews = self.subviews
        
        subviews.forEach { (view) in
            if let label = view as? UILabel {
                label.text = nil
            }
            
            // Description view //
            if let descriptionView = view.viewWithTag(0) {
                descriptionView.subviews.forEach({ (subView) in
                    if let label = subView as? UILabel {
                        label.text = nil
                    }
                })
            }
            
            // Indicator view //
            if let descriptionView = view.viewWithTag(1) {
                descriptionView.backgroundColor = UIColor.clear
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //-- Helpers --//
    func addSubviews() {
        let outerPadding = CGFloat(15)
        let innderPadding = CGFloat(8)
        
        //self.backgroundColor = UIColor.gray
        
        // Create uiview to hold titleLabel && locationLabel //
        let descriptionView = UIView()
        descriptionView.tag = 0
        descriptionView.frame = CGRect(x: (self.frame.width * 0.34), y: outerPadding, width: CGFloat(self.frame.width - self.frame.width * 0.34), height: self.frame.height)
        
        // Title label layout //
        self.titleLabel.frame = CGRect(x: 0, y: 0, width: descriptionView.frame.width, height: (descriptionView.frame.height * 0.5))

        // Location label layout //
        self.locationLabel.frame = CGRect(x: 0, y: (self.titleLabel.frame.height + innderPadding), width: descriptionView.frame.width, height: (descriptionView.frame.height - self.titleLabel.frame.height - innderPadding))
        
        // Add Title and location label //
        descriptionView.addSubview(self.titleLabel)
        descriptionView.addSubview(self.locationLabel)
        
        // Size to fit views //
        descriptionView.sizeToFit()
        
        // Add description view to cell view //
        self.addSubview(descriptionView)
        
        // Indicator layout //
        self.availabilityIndicator.frame = CGRect(x: (descriptionView.frame.minX - outerPadding * 1.5), y: outerPadding * 1.3, width: 12, height: 12)
        
        // Add to subview //
        self.addSubview(self.availabilityIndicator)
        
        // Date Time Layout //
        self.dateTimeLabel.frame = CGRect(x: (self.availabilityIndicator.frame.minX - self.frame.width * 0.15 - (outerPadding * 1.5) ), y: (outerPadding * 1.1), width: (self.frame.width * 0.15), height: self.titleLabel.frame.height)
        
        // Add to subview //
        self.addSubview(self.dateTimeLabel)
        
        // No Events Layout //
        self.noEventsLabel.frame = CGRect(x: (self.frame.minX + outerPadding), y: outerPadding, width: self.dateTimeLabel.frame.width, height: self.dateTimeLabel.frame.height)
        
        // Add to subview //
        self.addSubview(self.noEventsLabel)
    }
    
    func addCellData(appointment: Appointment?) {
        
        guard let scheduledAppointment = appointment else {
            self.noEventsLabel.text = "No events"
            self.noEventsLabel.sizeToFit()
            return
        }
        
        self.titleLabel.text = scheduledAppointment.title
        self.locationLabel.text = scheduledAppointment.location
        self.dateTimeLabel.text = scheduledAppointment.localizedTime
        
        if scheduledAppointment.available {
            self.availabilityIndicator.backgroundColor = availIndicatorColor
        } else {
            self.availabilityIndicator.backgroundColor = pendingIndicatorColor
        }
        
        // Size to fit //
        self.dateTimeLabel.sizeToFit()
    }

    /*override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }*/

}
