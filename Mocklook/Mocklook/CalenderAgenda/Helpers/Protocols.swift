//
//  Protocols.swift
//  Mocklook
//
//  Created by Alec Dilanchian on 3/5/18.
//  Copyright © 2018 Alec Dilanchian. All rights reserved.
//

import Foundation

//-- Send Data To Calendar View --//
protocol DateSyncDelegate {
    // Method to send IndexPath to calendar //
    func changeCurrentCalendarDate(stringDate: String)
    func changeCurrentAgendaDate(dayPath: IndexPath)
    func agendaIsActive()
    func calendarIsActive()
}
