//
//  CalendarCollectionViewController.swift
//  Mocklook
//
//  Created by Alec Dilanchian on 3/3/18.
//  Copyright © 2018 Alec Dilanchian. All rights reserved.
//

/*
    This is the calendar view, view controller! This is a collection view that is populated
    with 365 cells that scroll continuosly (year of 2018) that are separated into sections
    by each month of the year.
*/

import UIKit

class CalendarCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    //-- Properties --//
    var calendarManager: CalendarManager!
    var calenderCollectionView: UICollectionView!
    var currentSelection: IndexPath!
    var isExpanded: Bool!
    var delegate: DateSyncDelegate?
    
    // Resize CGRect //
    let shrinkSize = CGRect(x: 0, y: (Constants.Device.statusBarSize.height + 21), width: Constants.Device.screenSize.width, height: (Constants.Device.screenSize.height * 0.3))
    let expandSize = CGRect(x: 0, y: (Constants.Device.statusBarSize.height + 21), width: Constants.Device.screenSize.width, height: (Constants.Device.screenSize.height * 0.4))
    
    override func viewDidLoad() {
        print("Setting up collection view controller...")
        
        super.viewDidLoad()
        
        // Setup Calendar Manager //
        self.calendarManager = CalendarManager()
        
        // Setup Collection View //
        self.setupCollectionView()
        
        // Set current selection //
        self.currentSelection = self.calendarManager.currentCalendarIndexPath
        
        // Set isExpanded //
        self.isExpanded = true
    }
    
    //-- UICollectionViewDataSource --//
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // Return a section for each month of the year //
        return 12
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Each section should have number of days in month. +1 because date components requires it //
        return calendarManager.numDaysByMonth(month: section + 1)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as! CalendarCollectionViewCell
        
        // Cell Setup //
        cell.setDayLabel(monthDayPath: indexPath)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // If an item is selected, let the agenda know that it needs to update //
        if self.delegate != nil {
            self.delegate?.changeCurrentAgendaDate(dayPath: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        // gets rid of any gap between sections //
        return CGSize.zero
    }
    
    //-- Scroll View --//
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // If an scrolling has begun, the calendar is active //
        if self.delegate != nil {
            self.delegate?.calendarIsActive()
        }
    }
    
    //-- Helpers --//
    fileprivate func setupCollectionView() {
        // Set layout for collection view //
        let layout = UICollectionViewFlowLayout()
        // Divided by 7 so the width can always fit 7 items //
        layout.itemSize = CGSize(width: (Constants.Device.screenSize.width / 7), height: (Constants.Device.screenSize.width / 7))
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.headerReferenceSize = CGSize(width: Constants.Device.screenSize.width, height: 4.0)
        layout.sectionHeadersPinToVisibleBounds = true
        
        // Instantiate collection view //
        self.calenderCollectionView = UICollectionView(frame: CGRect(x: 0, y: (Constants.Device.statusBarSize.height + 21), width: Constants.Device.screenSize.width, height: (Constants.Device.screenSize.height * 0.4)), collectionViewLayout: layout)
        self.calenderCollectionView.backgroundColor = UIColor.white
        
        // Remove scroll indicators //
        self.calenderCollectionView.showsVerticalScrollIndicator = false
        self.calenderCollectionView.showsHorizontalScrollIndicator = false
        
        // Set delegate properties //
        self.calenderCollectionView.delegate = self
        self.calenderCollectionView.dataSource = self
        
        // Register cell class //
        self.calenderCollectionView.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: "DayCell")
        
        // Add to subview //
        self.view.addSubview(self.calenderCollectionView)
        print("Collection view controller setup.")
    }
}
