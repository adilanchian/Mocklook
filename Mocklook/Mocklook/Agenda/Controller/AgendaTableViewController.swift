//
//  AgendaTableViewController.swift
//  Mocklook
//
//  Created by Alec Dilanchian on 3/4/18.
//  Copyright © 2018 Alec Dilanchian. All rights reserved.
//

import UIKit

class AgendaTableViewController: UITableViewController {
    //-- Properties --//
    let appointmentManager = AppointmentManager()
    let calendarManager = CalendarManager()
    var agendaTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Generate mock appointments //
        self.appointmentManager.generateAppointments()
        
        // Sort appointments by section //
        self.appointmentManager.sortAppointments()
        
        // Setup Table View //
        self.setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // There should be a section for every day in the calendar //
        return self.calendarManager.sectionDays.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Get the key from dictionary //
        let sectionString = self.calendarManager.sectionDays[section]
        
        if self.appointmentManager.sortedAppointments.keys.contains(sectionString) {
            print("There are \(self.appointmentManager.sortedAppointments[sectionString]!.count) appointments for section: \(sectionString).")
            return self.appointmentManager.sortedAppointments[sectionString]!.count
        }
        
        // Need one cell to display "No events" message
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentCell", for: indexPath) as! AppointmentTableViewCell
        
        let sectionString = self.calendarManager.sectionDays[indexPath.section]
        
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
        return 24
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionString = self.calendarManager.sectionDays[indexPath.section]
        if self.appointmentManager.sortedAppointments.keys.contains(sectionString) {
            return 80
        }
        
        return 40
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Create header custom view //
        let sectionView = UIView()
    
        // Create UILabel //
        let dateLabel = UILabel()
        dateLabel.frame = CGRect(x: 15, y: 0, width: screenSize.maxX, height: 24)
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
    
    //-- Helpers --//
    func setupTableView() {
        // Instantiate table view //
        self.agendaTableView = UITableView(frame: CGRect(x: 0, y: (screenSize.maxY / 3), width: screenSize.maxX, height: (screenSize.maxY - screenSize.maxY / 3)), style: .plain)
        
        // Set delegates //
        self.agendaTableView.delegate = self
        self.agendaTableView.dataSource = self
        
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
