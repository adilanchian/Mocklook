//
//  CalendarAgendaViewController.swift
//  Mocklook
//
//  Created by Alec Dilanchian on 3/3/18.
//  Copyright © 2018 Alec Dilanchian. All rights reserved.
//

import UIKit

class CalendarAgendaViewController: UIViewController, DateSyncDelegate {
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
        
        // Set delegate for DateSyncDelegate //
        self.agenda.delegate = self
        
        print("Calender view setup.")
    }
    
    //-- DateSyncDelegate --//
    func changeCurrentCalendarDate(stringDate: String) {
        print("[CalendarAgendaView] Received new date from Agenda: \(stringDate)")
        
        // Calculate what indexPath this corresponds to in the calendar //
        guard let path = self.calendarManager.calculateCalendarPath(stringDate: stringDate) else {
            print("[CalendarAgendaView] Generated index path came back nil. Returning.")
            return
        }
        
        self.calendar.calenderCollectionView.scrollToItem(at: path, at: .top, animated: true)
    }
}
