//
//  Copyright (c) 2016 Keun young Kim <app@meetkei.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

public let SECOND: TimeInterval   = 1
public let MINUTE: TimeInterval   = 60
public let HOUR: TimeInterval     = MINUTE * 60
public let DAY: TimeInterval      = HOUR * 24
public let WEEK: TimeInterval     = DAY * 7
public let YEAR: TimeInterval     = DAY * 365

public enum Day: Int {
    case day1 = 1, day2, day3, day4, day5, day6, day7, day8, day9
    case day10, day11, day12, day13, day14, day15, day16, day17, day18, day19
    case day20, day21, day22, day23, day24, day25, day26, day27, day28, day29
    case day30, day31
}

public enum Weekday: Int {
    case sunday = 1
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
}

public enum Month: Int {
    case january = 1
    case february
    case march
    case april
    case may
    case june
    case july
    case august
    case september
    case october
    case novermber
    case december
}


public extension Date {
    /**
     The number of era units for **self**.
     */
    var era: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.era], from: self)
        return components.era!
    }
    
    
    
    /**
     The number of year units for **self**.
     */
    var year: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: self)
        return components.year!
    }
    
    
    
    /**
     The number of month units for **self**.
     */
    var month: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month], from: self)
        return components.month!
    }
    
    
    
    /**
     The number of day units for **self**.
     */
    var day: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: self)
        return components.day!
    }
    
    
    
    /**
     The number of hour units for **self**.
     */
    var hour: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour], from: self)
        return components.hour!
    }
    
    
    
    /**
     The number of minute units for **self**.
     */
    var minute: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute], from: self)
        return components.minute!
    }
    
    
    
    /**
     The number of second units for **self**.
     */
    var second: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.second], from: self)
        return components.second!
    }
    
    
    /**
     The number of the weekday unit for **self**.
     */
    var weekday: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: self)
        return components.weekday!
    }
    
    
    
    /**
     The ordinal number of weekday units for **self**.
     */
    var weekdayOrdinal: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekdayOrdinal], from: self)
        return components.weekdayOrdinal!
    }
    
    
    
    /**
     The number of quarters for **self**.
     */
    var quarter: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.quarter], from: self)
        return components.quarter!
    }
    
    
    
    /**
     The ISO 8601 week date of the year for **self**.
     */
    var weekOfYear: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekOfYear], from: self)
        return components.weekOfYear!
    }
    
    
    
    func removeTime() -> Date! {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: self as Date)
        
        var result = DateComponents()
        (result as NSDateComponents).timeZone = calendar.timeZone
        result.year = components.year
        result.month = components.month
        result.day = components.day
        result.hour = 0
        result.minute = 0
        result.second = 0
        
        return calendar.date(from: result)!
    }
    
    
    
    func startDateOfDay() -> Date {
        return self.removeTime()
    }
    
    
    
    func endDateOfDay() -> Date {
        let start = startDateOfDay()
        let tomorrow = Interval.dateByAddingDays(1, toDate: start)
        
        return Interval.dateByAddingSeconds(-1, toDate: tomorrow)
    }
    
    
    
    func startDateOfMonth() -> Date! {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.year, .month], from: self)
        
        var result = DateComponents()
        (result as NSDateComponents).timeZone = calendar.timeZone
        result.year = components.year
        result.month = components.month
        result.day = 1
        result.hour = 0
        result.minute = 0
        result.second = 0
        
        return calendar.date(from: result)!
    }
    
    
    func addMonths(_ months: Int = 1) -> Date {
        let calendar = Calendar.current
        var components = DateComponents()
        components.month = months
        
        return calendar.date(byAdding: components, to: self)!
    }
    
    
    
    func nextMonth() -> Date {
        return addMonths()
    }
    
    
    
    func lastMonth() -> Date {
        return addMonths(-1)
    }
    
    
    
    static func zeroDate() -> Date {
        return Date(timeIntervalSince1970: 0)
    }
}
