//
//  DateExtension.swift
//  MailerLite
//
//  Created by Adam Bardon on 20/02/2019.
//  Copyright © 2019 Adam Bardon. All rights reserved.
//

import Foundation

extension Date {
    var time: String {
        let f = DateFormatter()
        f.dateFormat = "HH:mm"
        return f.string(from: self)
    }
    
    var dayAndTime: String {
        let f = DateFormatter()
        f.dateFormat = "EE HH:mm"
        return f.string(from: self)
    }
    
    var monthAndDayAndTime: String {
        let f = DateFormatter()
        f.dateFormat = "MMMM dd HH:mm"
        return f.string(from: self)
    }
    
    var yearAndMonthAndDayAndTime: String {
        let f = DateFormatter()
        f.dateFormat = "dd MMM YYYY HH:mm"
        return f.string(from: self)
    }
    
    var shortDateAndTime: String {
        let f = DateFormatter()
        f.dateFormat = "dd.MM.YYYY HH:mm"
        return f.string(from: self)
    }
    
    func custom(format: String) -> String {
        let f = DateFormatter()
        f.dateFormat = format
        return f.string(from: self)
    }
    
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    func isInSameWeek() -> Bool {
        return Calendar.current.isDate(self, equalTo: Date(), toGranularity: .weekOfYear)
    }
    func isInSameMonth() -> Bool {
        return Calendar.current.isDate(self, equalTo: Date(), toGranularity: .month)
    }
    func isInSameYear() -> Bool {
        return Calendar.current.isDate(self, equalTo: Date(), toGranularity: .year)
    }
}
