//
//  XDateTool.swift
//  Chocolate
//
//  Created by BRUX on 3/16/15.
//  Copyright (c) 2015 brux All rights reserved.
//

import UIKit
import ObjectiveC

private var targetTimeFormatterAssociationKey:UInt8 = 0

public extension NSDate {
    func toString(formatter formatter:String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = formatter
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
        
        return dateFormatter.stringFromDate(self)
    }
}

public extension NSDate {
    /**
    获得当前实例的"yyyy-MM-dd"的格式化字符串
    
    - returns: 形如"yyyy-MM-dd"的格式化字符串
    */
    func yyyy_MM_ddString() -> String {        
        return toString(formatter: "yyyy-MM-dd")
    }
    
    private var targetTimeFormatter:NSDateFormatter {
        
        get {
            
            if let formatter = objc_getAssociatedObject(self, &targetTimeFormatterAssociationKey) as? NSDateFormatter {
                
                return formatter
                
            } else {
                
                let newFormatter = NSDateFormatter()
                
                newFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                
                self.targetTimeFormatter = newFormatter
                
                return newFormatter
            }
        }
        
        set {
            
            objc_setAssociatedObject(self, &targetTimeFormatterAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func toTargetTimeString() -> String {
        
        return self.targetTimeFormatter.stringFromDate(self)
    }
    
    public class func dateFrom_yyyy_MM_dd(raw: String) -> NSDate? {
    
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.dateFromString(raw)
    }
    
    class func monthString(year:Int, month:Int) -> String {
        let dc = NSDateComponents()
        dc.year = year
        dc.month = month
        dc.day = 1
        
        let calendar = NSCalendar.currentCalendar()
        
        if let date = calendar.dateFromComponents(dc) {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "M月"

            return dateFormatter.stringFromDate(date)
        }else {
            return ""
        }
    }
    
    /// 即将弃用，用class func yearMonthDayOfTheYear(theYear:Int, theMonth:Int, theDay:Int) -> (year:Int, month:Int, day:Int) 代替
    class func monthNumber(year:Int, month:Int) -> Int {
        let dc = NSDateComponents()
        dc.year = year
        dc.month = month
        dc.day = 1
        
        let calendar = NSCalendar.currentCalendar()
        
        if let date = calendar.dateFromComponents(dc) {
            let unitFlags:NSCalendarUnit = [.Year, .Month, .Day]
            let components = NSCalendar.currentCalendar().components(unitFlags, fromDate: date)
            return components.month
        }else {
            return 0
        }
    }
    
    /**
    规整化年月日，例如输入"2015-07-0"，输出"2015-06-30"
    
    - parameter theYear: 规整化前的年，例如 1988
    - parameter theMonth: 规整化前的月，例如 -3
    - parameter theDay: 规整化前的日，例如 50
    
    - returns: 规整化后的年月日元组，例如 （1987,10,20）
    */
    public class func yearMonthDayOfTheYear(theYear:Int, theMonth:Int, theDay:Int) -> (year:Int, month:Int, day:Int) {
        let dc = NSDateComponents()
        dc.year = theYear
        dc.month = theMonth
        dc.day = theDay
        
        let calendar = NSCalendar.currentCalendar()
        if let date = calendar.dateFromComponents(dc) {
            let unitFlags:NSCalendarUnit = [.Year, .Month, .Day]
            let components = NSCalendar.currentCalendar().components(unitFlags, fromDate: date)
            return (components.year,components.month,components.day)
        }else {
            return (0,0,0)
        }
    }
    
    /**
    输出此刻的年月日
    
    - returns: 年月日元组，例如 （1987,10,20）
    */
    public class func yearMonthDayOfNow() -> (year:Int, month:Int, day:Int) {
        let unitFlags:NSCalendarUnit = [.Year, .Month, .Day]
        let components = NSCalendar.currentCalendar().components(unitFlags, fromDate: NSDate())
        return (components.year,components.month,components.day)
        
        //TODO: - this line just for test. use the line above instead when done
        //return (2015,7,30)
    }
    
    /**
    将NSDate转换为年月日元组
    
    - parameter date: 需要转换的NSDate对象
    
    - returns: 年月日元组，例如 （1987,10,20）
    */
    public class func yearMonthDayOfDate(date:NSDate) -> (year:Int, month:Int, day:Int) {
        let unitFlags:NSCalendarUnit = [.Year, .Month, .Day]
        let components = NSCalendar.currentCalendar().components(unitFlags, fromDate: date)
        return (components.year,components.month,components.day)
    }
    
    public  func yearMonthDayOfDate() -> (year:Int, month:Int, day:Int) {
        let unitFlags:NSCalendarUnit = [.Year, .Month, .Day]
        let components = NSCalendar.currentCalendar().components(unitFlags, fromDate: self)
        return (components.year,components.month,components.day)
    }
    
    public class func dayCountOfMonth(monthOffset:Int = 0) -> Int {
        let (thisYear,thisMonth,_) = NSDate.yearMonthDayOfNow()
        return dayCountOfMonth(thisMonth + monthOffset, ofYear: thisYear)
    }
    
    public class func dayCountFromDay(fromDay : (year:Int, month:Int, day:Int), toDay : (year:Int, month:Int, day:Int)) -> Int {
        let calendar = NSCalendar.currentCalendar()
        let fdc = NSDateComponents()
        fdc.year = fromDay.year
        fdc.month = fromDay.month
        fdc.day = fromDay.day
        
        if let fd = calendar.dateFromComponents(fdc) {
            let tdc = NSDateComponents()
            tdc.year = toDay.year
            tdc.month = toDay.month
            tdc.day = toDay.day
            
            if let td = calendar.dateFromComponents(tdc) {
                let sec = td.timeIntervalSinceDate(fd)
                return Int(sec) / 86400
            }
        }
        return 0
    }
    
    public class func dayCountOfMonth(month:Int, ofYear year:Int) -> Int {
        let dc = NSDateComponents()
        dc.year = year
        dc.month = month
        dc.day = 1
        
        let calendar = NSCalendar.currentCalendar()
        
        if let date = calendar.dateFromComponents(dc) {
            return calendar.rangeOfUnit(.Day, inUnit: .Month, forDate: date).length
        }else {
            return -1
        }
    }
    
    public class func weekdayOrdinalOfFirstDayIn(year year:Int, month:Int) -> Int {
        return weekdayOrdinalOf(year: year, month: month, day: 1)
    }
    
    public class func weekdayOrdinalOf(year year:Int, month:Int, day:Int) -> Int {
        let dc   = NSDateComponents()
        dc.year  = year
        dc.month = month
        dc.day   = day
        
        let calendar = NSCalendar.currentCalendar()
        
        if let date = calendar.dateFromComponents(dc) {
            return calendar.ordinalityOfUnit(.Weekday, inUnit: .WeekOfMonth, forDate: date)
        }else {
            return -1
        }
    }
}

extension NSDate {
    public class func BXMoment24HoursAgo() -> NSDate {
        return NSDate(timeIntervalSinceNow: -86400)
    }
    
    public class func BXMomentZeroHourToday() -> NSDate {
        let now = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "H"
        let hours = Int(dateFormatter.stringFromDate(now))!
        dateFormatter.dateFormat = "m"
        let minutes = Int(dateFormatter.stringFromDate(now))!
        dateFormatter.dateFormat = "s"
        let seconds = Int(dateFormatter.stringFromDate(now))!
        
        let timeInterval = -(((hours * 60 + minutes) * 60) + seconds)
        return NSDate(timeIntervalSinceNow: NSTimeInterval(timeInterval))
    }
    
    
    public class func BXMomentTodayWith(hours hours:Int,minutes:Int,seconds:Int) ->NSDate? {
        if (hours > 23 || hours < 0 || minutes > 60 || minutes < 0 || seconds > 60 || seconds < 0) {
            return nil
        }
        
        return NSDate(timeInterval: NSTimeInterval(((hours * 60 + minutes) * 60) + seconds), sinceDate: NSDate.BXMomentZeroHourToday())
    }
    
    public class func BXMomentHourBy(dayOffset dayOffset:Int,sinceDate:NSDate) -> NSDate {
        return NSDate(timeInterval: NSTimeInterval(dayOffset * 86400), sinceDate: sinceDate)
    }
}

extension NSDate {
    /// Initializes an NSDate instance with the given date and time parameters.
    public convenience init(year: Int, month: Int, day: Int, hour: Int, minute: Int = 0, second: Int = 0) {
        let components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second
        
        self.init(timeInterval: 0, sinceDate: NSCalendar.currentCalendar().dateFromComponents(components)!)
    }
    
    /// Initializes an NSDate instance with the given date parameters.
    public convenience init(year: Int, month: Int, day: Int) {
        self.init(year: year, month: month, day: day, hour: 0)
    }
}

extension NSTimeInterval {
    public func toMinSecString() -> String {
        let seconds = Int64(self)
        let minString = seconds / 60 > 0 ? "\(seconds / 60)" : "00"
        let secString = seconds % 60 > 9 ? "\(seconds % 60)" : "0\(seconds % 60)"
        return "\(minString):\(secString)"
    }
}
