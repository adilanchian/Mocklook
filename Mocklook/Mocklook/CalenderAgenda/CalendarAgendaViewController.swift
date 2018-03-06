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
    
    override func viewDidAppear(_ animated: Bool) {
        let selectedCell = self.calendar.calenderCollectionView.cellForItem(at: self.calendar.currentSelection) as? CalendarCollectionViewCell
        selectedCell?.backgroundColor = calenderSelectedColor
        selectedCell?.dayLabel.textColor = UIColor.white
    }
    
    //-- Helpers --//
    func setupCalenderView() {
        self.calendar = CalendarCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        self.calendar.view.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height / 3)
        self.addChildViewController(self.calendar)
        self.view.addSubview(self.calendar.calenderCollectionView)
        
        // Scroll to current section //
        self.calendar.calenderCollectionView.scrollToItem(at: self.calendar.currentSelection, at: .centeredVertically, animated: true)
        print("Calender view setup.")
        
        // Setup delegate for DateSyncDelegate //
        self.calendar.delegate = self
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
        
        // Remove background color on current selection //
        if let currentCell = self.calendar.calenderCollectionView.cellForItem(at: self.calendar.currentSelection) as? CalendarCollectionViewCell {
            
            currentCell.deselectCell()
        }
        
        // Center collection view vertically //
        self.calendar.calenderCollectionView.scrollToItem(at: path, at: .centeredVertically, animated: true)
        
        // Set background view on new cell //
        if let newCell = self.calendar.calenderCollectionView.cellForItem(at: path) as? CalendarCollectionViewCell {
            newCell.selectCell()
        }
        
        // Set currentSelection to new cell path //
        self.calendar.currentSelection = path
    }
    
    func changeCurrentAgendaDate(dayPath: IndexPath) {
        print("[CalendarAgendaView] Received new date from Calendar: \(dayPath)")
        
        // Calculate what indexPath this corresponds to in the calendar //
        let path = self.calendarManager.calculateAgendaPath(dayPath: dayPath)
        
        // Remove background color on current selection //
        if let currentCell = self.calendar.calenderCollectionView.cellForItem(at: self.calendar.currentSelection) as? CalendarCollectionViewCell {
            
            currentCell.deselectCell()
        }
        
        // Set background view on new cell //
        if let newCell = self.calendar.calenderCollectionView.cellForItem(at: dayPath) as? CalendarCollectionViewCell {
            newCell.selectCell()
        }
        
        // Set currentSelection to new cell path //
        self.calendar.currentSelection = dayPath
        
        // Scroll agenda view to calculated path //
        self.agenda.agendaTableView.scrollToRow(at: path, at: .top, animated: true)
    }
    
    func agendaIsActive() {
        // If calendar is expanded, shrink //
        print("Agenda is active...")
        if self.calendar.isExpanded {
            self.calendar.isExpanded = false
            self.agenda.isExpanded = true
            
            // Shrink calendar //
            self.calendar.shrink()
            
            // Expand agenda //
            self.agenda.expand()
        }
    }
    
    func calendarIsActive() {
        print("Calendar is active...")
        if self.agenda.isExpanded {
            self.agenda.isExpanded = false
            self.calendar.isExpanded = true
            
            // Shrink agenda //
            self.agenda.shrink()
            
            // Expand calendar //
            self.calendar.expand()
        }
    }
}
