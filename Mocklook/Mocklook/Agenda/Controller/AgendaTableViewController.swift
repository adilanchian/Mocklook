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
        
        // Setup Table View //
        self.setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //-- Table view data source --//
    override func numberOfSections(in tableView: UITableView) -> Int {
        // There should be a section for every day in the calendar //
        return self.calendarManager.sectionDays.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Will use mock data for number of rows in each section //
        return self.appointmentManager.appointments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentCell", for: indexPath) as! AppointmentTableViewCell
        
        cell.addCellData(appointment: self.appointmentManager.appointments[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
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
            dateLabel.textColor = textColor
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
        self.agendaTableView = UITableView(frame: CGRect(x: 0, y: (screenSize.maxY / 3), width: screenSize.maxX, height: (screenSize.maxY - screenSize.maxY / 3)), style: .grouped)
        
        // Set delegates //
        self.agendaTableView.delegate = self
        self.agendaTableView.dataSource = self
        
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
