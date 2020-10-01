//
//  TheDate.swift
//  WorkControll
//
//  Created by Илалов Андрей on 21/11/2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

import Foundation

class TheDate {
    static var shared = TheDate()
    var date: Double?
}


extension Date {
    var dateString: String {
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        formatter.locale = Locale.autoupdatingCurrent
        let date = self
        
        let day = formatter.string(from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        let monthName = formatter.monthSymbols[month - 1]
        let hours = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let dateString = String(format: "%@ %@ %d в %d:%d", day, monthName, year, hours, minutes)
        return dateString
    }
}
