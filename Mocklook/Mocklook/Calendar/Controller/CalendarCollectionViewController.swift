//
//  CalendarCollectionViewController.swift
//  Mocklook
//
//  Created by Alec Dilanchian on 3/3/18.
//  Copyright © 2018 Alec Dilanchian. All rights reserved.
//

import UIKit

class CalendarCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    //-- Properties --//
    var calendarManager: CalendarManager!
    var calenderCollectionView: UICollectionView!
    var currentSelection: IndexPath!
    var isExpanded: Bool!
    
    override func viewDidLoad() {
        print("Setting up collection view controller...")
        
        super.viewDidLoad()
        
        // Setup Calendar Manager //
        self.calendarManager = CalendarManager()
        
        // Setup Collection View //
        self.setupCollectionView()
        
        // Set current selection //
        self.currentSelection = IndexPath(item: self.calendarManager.currentDay - 1, section: self.calendarManager.currentMonth - 1)
        
        // Set isExpanded //
        self.isExpanded = true
    }
    
    //-- UICollectionViewDataSource --//
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // Return a section for each month of the year //
        return 12
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Each section should have number of days in month //
        return calendarManager.numDaysByMonth(month: section + 1)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as! CalendarCollectionViewCell
        
        // Cell Setup //
        cell.setDayLabel(monthDayPath: indexPath)
        
        return cell
    }
    
    //-- UICollectionViewDelegate --//
    /* override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if indexPath.section == 0 {
            if let weekdaysView = self.calenderCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "WeekDays", for: indexPath) as? WeekdaysCollectionReusableView {
                return weekdaysView
            }
        }
        
        return UICollectionReusableView()
     } */
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: self.calenderCollectionView.frame.width, height: 4.0)
        } else {
            return CGSize.zero
        }
    }
    
    //-- Helpers --//
    func setupCollectionView() {
        // Set layout for collection view //
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screenSize.maxX / 7, height: screenSize.maxX / 7)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.headerReferenceSize = CGSize(width: screenSize.width, height: 4.0)
        layout.sectionHeadersPinToVisibleBounds = true
        self.calenderCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: screenSize.maxX, height: screenSize.maxY / 3), collectionViewLayout: layout)
        self.calenderCollectionView.backgroundColor = UIColor.white
        
        // Remove scroll indicators //
        self.calenderCollectionView.showsVerticalScrollIndicator = false
        self.calenderCollectionView.showsHorizontalScrollIndicator = false
        
        // Set delegate properties //
        self.calenderCollectionView.delegate = self
        self.calenderCollectionView.dataSource = self
        
        // Register cell class //
        self.calenderCollectionView.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: "DayCell")
        
        // Register header class //
        self.calenderCollectionView.register(WeekdaysCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "WeekDays")
        
        // Add to subview //
        self.view.addSubview(self.calenderCollectionView)
        print("Collection view controller setup.")
    }
    
    func shrink() {
        // Shrink height of calendar view //
        self.calenderCollectionView.frame = CGRect(x: 0, y: 0, width: screenSize.maxX, height: (screenSize.maxY * 0.2))
    }
    
    func expand() {
        
    }
}
