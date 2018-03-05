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
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Appointment Title"
        return label
    }()
    
    var locationLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Appointment Location"
        return label
    }()
    
    var dateTimeLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Date Time Label Thing"
        return label
    }()
    
    var noEventsLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "No events"
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Setup elements in cell //
        self.setupSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        let subviews = self.subviews
        
        subviews.forEach { (view) in
            if let label = view as? UILabel {
                label.text = nil
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //-- Helpers --//
    func setupSubviews() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.locationLabel)
        self.addSubview(self.dateTimeLabel)
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        self.dateTimeLabel.text = dateFormatter.string(from: scheduledAppointment.dateTime)
        
        // Run size to fit //
        self.titleLabel.sizeToFit()
        self.locationLabel.sizeToFit()
        self.dateTimeLabel.sizeToFit()
    }

    /*override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }*/

}
