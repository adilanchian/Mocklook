//
//  AgendaTableViewController.swift
//  Mocklook
//
//  Created by Alec Dilanchian on 3/4/18.
//  Copyright © 2018 Alec Dilanchian. All rights reserved.
//

/*
    This is the agenda view controller! This is a table view controller that handles all
    the interactions with the agenda view.
*/

import UIKit

class AgendaTableViewController: UITableViewController, UITableViewDataSourcePrefetching {
    //-- Properties --//
    let appointmentManager = AppointmentManager()
    let calendarManager = CalendarManager()
    var agendaTableView: UITableView!
    var delegate: DateSyncDelegate?
    var isExpanded: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Generate mock appointments //
        self.appointmentManager.generateAppointments()
        
        // Sort appointments by section //
        self.appointmentManager.sortAppointments()
        
        // Setup Table View //
        self.setupTableView()
        
        // Set isExpanded //
        self.isExpanded = false
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // There should be a section for every day in the calendar //
        return self.calendarManager.sectionDays.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Get the key from dictionary. A dictionary is used to associate the day with an array of Appointments //
        var sectionString = self.calendarManager.sectionDays[section]
        
        // Need to remove the 'Today · ' string when checking for key //
        if sectionString.range(of: "Today · ") != nil {
            sectionString = sectionString.replacingOccurrences(of: "Today · ", with: "")
        }
        
        if self.appointmentManager.sortedAppointments.keys.contains(sectionString) {
            return self.appointmentManager.sortedAppointments[sectionString]!.count
        }
        
        // Need one cell to display "No events" message //
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentCell", for: indexPath) as! AppointmentTableViewCell
        
        var sectionString = self.calendarManager.sectionDays[indexPath.section]
        
        // Need to remove the 'Today · ' string when checking for key //
        if sectionString.range(of: "Today · ") != nil {
            sectionString = sectionString.replacingOccurrences(of: "Today · ", with: "")
        }
        
        // Get the key from dictionary //
        if self.appointmentManager.sortedAppointments.keys.contains(sectionString) {
            let appointments = self.appointmentManager.sortedAppointments[sectionString]!
            cell.addCellData(appointment: appointments[indexPath.row])
        } else {
            cell.addCellData(appointment: nil)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // Setting the section header size //
        return 24
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var sectionString = self.calendarManager.sectionDays[indexPath.section]
        
        // Need to remove the 'Today · ' string when checking for key //
        if sectionString.range(of: "Today · ") != nil {
            sectionString = sectionString.replacingOccurrences(of: "Today · ", with: "")
        }
        
        if self.appointmentManager.sortedAppointments.keys.contains(sectionString) {
            return 80
        }
        
        // This is for a 'No events' cell //
        return 40
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Create header custom view //
        let sectionView = UIView()
    
        // Create UILabel //
        let dateLabel = UILabel()
        dateLabel.frame = CGRect(x: 15, y: 0, width: screenSize.width, height: 24)
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        
        // Get string for section //
        let sectionString = self.calendarManager.sectionDays[section]
        
        // If string contains Today, change font color/view bg //
        if sectionString.range(of: "Today") != nil {
            sectionView.backgroundColor = todaySectionBgColor
            dateLabel.textColor = todaySectionTxtColor
        } else {
            sectionView.backgroundColor = disabledColor
            dateLabel.textColor = grayTextColor
        }
        
        // Set dateLabel string //
        dateLabel.text = sectionString
        
        // Add to subview //
        sectionView.addSubview(dateLabel)
        return sectionView
    }
    
    //-- Prefetch data source --//
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { (path) in
            var sectionString = self.calendarManager.sectionDays[path.section]
            
            // Need to remove the 'Today · ' string when checking for key //
            if sectionString.range(of: "Today · ") != nil {
                sectionString = sectionString.replacingOccurrences(of: "Today · ", with: "")
            }
            
            // Get array of appointments //
            if let appointment = self.appointmentManager.sortedAppointments[sectionString]?[path.row] {
                
                // Attempt to get the temperature for the current location //
                appointment.getTemperature()
            }
        }
    }
    
    //-- Scroll View --//
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // When scrolling begins, let the calendar know the agenda is active //
        if self.delegate != nil {
            self.delegate?.agendaIsActive()
        }
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let firstCell = self.agendaTableView.indexPathsForVisibleRows?[0] else {
            print("No visible cells in table. Returning.")
            return
        }

        if self.delegate != nil {
            // Get uiview for header view //
            guard let headerView = self.tableView(self.agendaTableView, viewForHeaderInSection: firstCell.section) else {
                print("Could not grab header section view. Returning.")
                return
            }
            
            // Get the label that has the title of the section to send over to Calendar View //
            headerView.subviews.forEach({ (view) in
                if let label = view as? UILabel {
                    
                    // Need to remove the 'Today · ' string when checking for key //
                    if label.text?.range(of: "Today · ") != nil {
                        label.text = label.text!.replacingOccurrences(of: "Today · ", with: "")
                    }
                    
                    // Make sure to position top most cell at the top of the view //
                    self.agendaTableView.scrollToRow(at: firstCell, at: .top, animated: true)
                    
                    // Time to update the calender! //
                    self.delegate!.changeCurrentCalendarDate(stringDate: label.text!)
                }
            })
        }
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard let firstCell = self.agendaTableView.indexPathsForVisibleRows?[0] else {
            print("No visible cells in table. Returning.")
            return
        }
        
        if !decelerate {
            // Send delegate message //
            if self.delegate != nil {
                
                // Get uiview for header view //
                guard let headerView = self.tableView(self.agendaTableView, viewForHeaderInSection: firstCell.section) else {
                    print("Could not grab header section view. Returning.")
                    return
                }
                
                // Get the label that has the title of the section to send over to Calendar View //
                headerView.subviews.forEach({ (view) in
                    if let label = view as? UILabel {
                        if label.text?.range(of: "Today · ") != nil {
                            label.text = label.text!.replacingOccurrences(of: "Today · ", with: "")
                        }
                        
                        // Time to update teh calendar ! //
                        self.delegate?.changeCurrentCalendarDate(stringDate: label.text!)
                    }
                })
            }
        }
    }
    
    //-- Helpers --//
    func setupTableView() {
        // Instantiate table view //
        self.agendaTableView = UITableView(frame: CGRect(x: 0, y: (screenSize.height * 0.4), width: screenSize.width, height: (screenSize.height - screenSize.height * 0.4)), style: .plain)
        
        // Set delegates //
        self.agendaTableView.delegate = self
        self.agendaTableView.dataSource = self
        self.agendaTableView.prefetchDataSource = self
        
        // Remove scroll indicator //
        self.agendaTableView.showsVerticalScrollIndicator = false
        self.agendaTableView.showsHorizontalScrollIndicator = false
        
        // Do not show a footer //
        self.agendaTableView.sectionFooterHeight = 0
        
        // Register cell class //
        self.agendaTableView.register(AppointmentTableViewCell.self, forCellReuseIdentifier: "AppointmentCell")
        
        // Get section dates //
        self.calendarManager.getEachDayForYear()
        
        // Add UITable to view //
        self.view.addSubview(self.agendaTableView)
    }
    
    func expand() {
        // Expand size of agenda view and move up //
        UIView.animate(withDuration: 0.2) {
            self.agendaTableView.frame = CGRect(x: 0, y: (screenSize.height * 0.3), width: screenSize.width, height: (screenSize.height - (screenSize.height * 0.3)))
        }
    }
    
    func shrink() {
        // Shrink size of agenda view and move down //
        UIView.animate(withDuration: 0.2) {
            self.agendaTableView.frame = CGRect(x: 0, y: (screenSize.height * 0.4), width: screenSize.width, height: (screenSize.height - screenSize.height * 0.4))
            
        }
    }
}
