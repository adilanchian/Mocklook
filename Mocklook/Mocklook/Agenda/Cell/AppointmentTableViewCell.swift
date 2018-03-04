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
    let titleLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Appointment Title"
        return label
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Appointment Location"
        return label
    }()
    
    let dateTimeLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Date Time Label Thing"
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Setup elements in cell //
        self.setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //-- Helpers --//
    func setupSubviews() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.locationLabel)
        self.addSubview(self.dateTimeLabel)
    }
    
    func addCellData(appointment: Appointment) {
        self.titleLabel.text = appointment.title
        self.locationLabel.text = appointment.location
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        self.dateTimeLabel.text = dateFormatter.string(from: appointment.dateTime)
        
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
