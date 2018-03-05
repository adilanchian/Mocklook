//
//  CalendarAgendaViewController.swift
//  Mocklook
//
//  Created by Alec Dilanchian on 3/3/18.
//  Copyright © 2018 Alec Dilanchian. All rights reserved.
//

import UIKit

class CalendarAgendaViewController: UIViewController {
    //-- Properties --//
    var calendar: CalendarCollectionViewController!
    var agenda: AgendaTableViewController!
    var calendarManager: CalendarManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.calendarManager = CalendarManager()
        
        print("Setting up calender view...")
        self.setupCalenderView()
        
        print("Setting up agenda view...")
        self.setupAgendaView()
    }
    
    //-- Helpers --//
    func setupCalenderView() {
        self.calendar = CalendarCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        self.calendar.view.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height / 3)
        self.addChildViewController(self.calendar)
        self.view.addSubview(self.calendar.calenderCollectionView)
        
        // Scroll to current section //
        self.calendar.calenderCollectionView.scrollToItem(at: IndexPath(row: 0, section: self.calendarManager.currentMonth - 1), at: .top, animated: true)
        print("Calender view setup.")
    }
    
    func setupAgendaView() {
        self.agenda = AgendaTableViewController()
        self.agenda.view.frame = CGRect(x: 0, y: screenSize.height / 3, width: screenSize.width, height: screenSize.height - screenSize.height / 3)
        self.addChildViewController(self.agenda)
        self.view.addSubview(self.agenda.agendaTableView)
        
        // Scroll to current date section //
        self.agenda.agendaTableView.scrollToRow(at: IndexPath(item: 0, section: calendarManager.todayDateSection), at: .top, animated: true)
        
        print("Calender view setup.")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
