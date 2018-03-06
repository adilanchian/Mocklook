//
//  Protocols.swift
//  Mocklook
//
//  Created by Alec Dilanchian on 3/5/18.
//  Copyright © 2018 Alec Dilanchian. All rights reserved.
//

/*
    This file holds the protocol used to communicate between the agenda and calendar
*/

import Foundation

//-- Send Data To Calendar View --//
protocol DateSyncDelegate {
    // When agenda date changes, reflect in calendar //
    func changeCurrentCalendarDate(stringDate: String)
    
    // When calendar date changes, reflect in agenda //
    func changeCurrentAgendaDate(dayPath: IndexPath)
    
    // Let the root controller know the agenda is active //
    func agendaIsActive()
    
    // Let the root controller know the calendar is active //
    func calendarIsActive()
}
