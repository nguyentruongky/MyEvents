//
//  DateExtension.swift
//  kLibrary
//
//  Created by Ky Nguyen on 1/26/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import Foundation

extension Date {
    
    var timeAgo: String {
        
        let now = Date()
        
        let components = Calendar.current.dateComponents(
            [.year, .month, .weekOfYear, .day, .hour, .minute, .second],
            from: now,
            to: self
        )
        
        if let years = components.year, years > 0 {
            return "\(years) year\(years == 1 ? "" : "s") ago"
        }
        
        if let months = components.month, months > 0 {
            return "\(months) month\(months == 1 ? "" : "s") ago"
        }
        
        if let weeks = components.weekOfYear, weeks > 0 {
            return "\(weeks) week\(weeks == 1 ? "" : "s") ago"
        }
        if let days = components.day, days > 0 {
            guard days > 1 else { return "yesterday" }
            
            return "\(days) day\(days == 1 ? "" : "s") ago"
        }
        
        if let hours = components.hour, hours > 0 {
            return "\(hours) hour\(hours == 1 ? "" : "s") ago"
        }
        
        if let minutes = components.minute, minutes > 0 {
            return "\(minutes) minute\(minutes == 1 ? "" : "s") ago"
        }
        
        if let seconds = components.second, seconds > 30 {
            return "\(seconds) second\(seconds == 1 ? "" : "s") ago"
        }
        
        return "just now"
    }
    
    static func dateFrom(year: Int = 1970, month: Int = 1, day: Int = 1, hour: Int = 0, minute: Int = 0, second: Int = 0) -> Date? {
        
        var component = DateComponents()
        component.year = year
        component.month = month
        component.day = day
        component.hour = hour
        component.minute = minute
        component.second = second
        component.timeZone = TimeZone(abbreviation: "GMT")
        
        return Calendar.current.date(from: component)!
    }
    
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    func startOfMonth() -> Date? {
        let cal: Calendar = Calendar.current
        var comp: DateComponents = (cal as Calendar).dateComponents([.year, .month], from: self)
        comp.hour = 12
        comp.minute = 0
        comp.second = 0
        return cal.date(from: comp)
    }
    
    func endOfMonth() -> Date? {
        let cal: Calendar = Calendar.current
        var comp: DateComponents = (cal as Calendar).dateComponents([.year, .month], from: self)
        comp.month = 1
        comp.day = comp.day! - 1
        comp.hour = 12
        comp.minute = 0
        comp.second = 0
        return cal.date(from: comp)
    }
    
    init(localTimeFromIso8601String dateString:String) {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.calendar =  Calendar(identifier: Calendar.Identifier.iso8601)
        
        var d = dateFormatter.date(from: dateString)
        
        if d == nil {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        }
        d = dateFormatter.date(from: dateString)
        
        self.init(timeInterval:0, since:d!)

    }
    
    init(dateString: String, format: String, locale: Locale = Locale(identifier: "en_US_POSIX")) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        
        dateFormatter.dateFormat = format
        dateFormatter.calendar =  Calendar(identifier: Calendar.Identifier.iso8601)
        
        let d = dateFormatter.date(from: dateString)
        self.init(timeInterval:0, since:d!)
    }
    
    init(iso8601String:String) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.calendar =  Calendar(identifier: Calendar.Identifier.iso8601)
        
        var d = dateFormatter.date(from: iso8601String)
        
        if d == nil {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        }
        d = dateFormatter.date(from: iso8601String)
        
        self.init(timeInterval:0, since:d!)
    }
    
    static var currentYear: Int {
        get {
            return Calendar.current.component(.year, from: Date())
        }
    }
    
    static var currentMonth: Int {
        get {
            return Calendar.current.component(.month, from: Date())
        }
    }
    
    static var currentDay: Int {
        get {
            return Calendar.current.component(.day, from: Date())
        }
    }
    
    static var currentHour: Int {
        get {
            return Calendar.current.component(.hour, from: Date())
        }
    }
    
    static var currentMinute: Int {
        get {
            return Calendar.current.component(.minute, from: Date())
        }
    }
    
    
    var year: Int {
        get {
            return Calendar.current.component(.year, from: self)
        }
    }
    
    var month: Int {
        get {
            return Calendar.current.component(.month, from: self)
        }
    }
    
    var day: Int {
        get {
            return Calendar.current.component(.day, from: self)
        }
    }
    
    var hour: Int {
        get {
            return Calendar.current.component(.hour, from: self)
        }
    }
    
    var minute: Int {
        get {
            return Calendar.current.component(.minute, from: self)
        }
    }
    
    /**
     default format "MM/dd/yyyy"
     */
    func toString(_ format: String = "MM/dd/yyyy", locale: Locale = Locale(identifier: "en_US_POSIX")) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func currentTimeZoneDate(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func toISO8601String() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        dateFormatter.calendar =  Calendar(identifier: Calendar.Identifier.iso8601)
        return dateFormatter.string(from: self) + "Z"
    }
    
    func getElapsedInterval() -> String {
        
        var interval = (Calendar.current as NSCalendar).components(.year, from: self, to: Date(), options: []).year
        
        if interval! > 0 {
            return interval == 1 ? "\(String(describing: interval)) year" : "\(String(describing: interval)) years"
        }
        
        interval = (Calendar.current as NSCalendar).components(.month, from: self, to: Date(), options: []).month
        if interval! > 0 {
            return interval == 1 ? "\(String(describing: interval)) month" : "\(String(describing: interval)) months"
        }
        
        interval = (Calendar.current as NSCalendar).components(.day, from: self, to: Date(), options: []).day
        if interval! > 0 {
            return interval == 1 ? "\(String(describing: interval)) day" : "\(String(describing: interval)) days"
        }
        
        interval = (Calendar.current as NSCalendar).components(.hour, from: self, to: Date(), options: []).hour
        if interval! > 0 {
            return interval == 1 ? "\(String(describing: interval)) hour" : "\(String(describing: interval)) hours"
        }
        
        interval = (Calendar.current as NSCalendar).components(.minute, from: self, to: Date(), options: []).minute
        if interval! > 0 {
            return interval == 1 ? "\(String(describing: interval)) minute" : "\(String(describing: interval)) minutes"
        }
        
        return "a moment ago"
    }
    
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
