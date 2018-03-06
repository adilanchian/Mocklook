//
//  CalendarAgendaViewController.swift
//  Mocklook
//
//  Created by Alec Dilanchian on 3/3/18.
//  Copyright © 2018 Alec Dilanchian. All rights reserved.
//

/*
    This is the root ViewController that will hold the Agenda and Calendar view.
    This controller also conforms to the DateSyncDelegate which is used to
    update each view based on interaction with one another.
*/

import UIKit

class CalendarAgendaViewController: UIViewController, DateSyncDelegate {
    //-- Properties --//
    var calendar: CalendarCollectionViewController!
    var agenda: AgendaTableViewController!
    var calendarManager: CalendarManager!
    var weekView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.calendarManager = CalendarManager()
        
        print("Setting up week view...")
        self.setupWeekView()
        
        print("Setting up calender view...")
        self.setupCalenderView()
        
        print("Setting up agenda view...")
        self.setupAgendaView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Make sure we can access the cell and set the selected attribute on it //
        let selectedCell = self.calendar.calenderCollectionView.cellForItem(at: self.calendar.currentSelection) as? CalendarCollectionViewCell
        selectedCell?.selectCell()
    }
    
    //-- Helpers --//
    func setupWeekView() {
        self.weekView = UIView(frame: CGRect(x: 0, y: statusBarSize.height, width: screenSize.width, height: 21))
        
        // For weekday symbols //
        let formatter = DateFormatter()
        
        // To set label horizontally //
        var currentX = 0
        
        for item in 0...6 {
            let label = UILabel(frame: CGRect(x: currentX, y: 0, width: (Int(self.weekView.frame.width / 7)), height: 21))
            label.text = formatter.veryShortStandaloneWeekdaySymbols[item]
            label.font = UIFont.systemFont(ofSize: 12)
            label.textColor = grayTextColor
            label.textAlignment = .center
            
            // Create border bottom effect //
            let borderBottom = CALayer()
            borderBottom.frame = CGRect(x: 0, y: label.frame.height - 1, width: label.frame.width, height: 1.0)
            borderBottom.backgroundColor = separatorColor.cgColor
            label.layer.addSublayer(borderBottom)
            
            // Add to subview and then make sure next x coordinate is to the right of it //
            self.weekView.addSubview(label)
            currentX = currentX + Int(self.weekView.frame.width / 7)
        }
        
        self.view.addSubview(self.weekView)
        print("Week view setup.")
    }
    
    func setupCalenderView() {
        self.calendar = CalendarCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        // Account for the status bar and the height of the week bar //
        self.calendar.view.frame = CGRect(x: 0, y: (statusBarSize.height + 21), width: screenSize.width, height: (screenSize.height * 0.4))
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
        
        // Account for the ending position of the calendar view //
        self.agenda.view.frame = CGRect(x: 0, y: (screenSize.height * 0.4), width: screenSize.width, height: screenSize.height - (screenSize.height * 0.4))
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
        // If using the agenda view, shrink the calender view //
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
        // If using the calendar view, shrink the agenda view //
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
