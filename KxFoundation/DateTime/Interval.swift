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

infix operator ~ : MultiplicationPrecedence
public func ~(lhs: Date, rhs: Date) -> TimeInterval {
    return lhs.timeIntervalSince1970 - rhs.timeIntervalSince1970
}

public struct Interval {
    public static func exceeded(_ interval: TimeInterval, minDate: Date, maxDate: Date = Today.now) -> Bool {
        return maxDate.timeIntervalSinceReferenceDate - minDate.timeIntervalSinceReferenceDate > interval
    }
    
    
    
    public static func dateByAdding(toDate date: Date, year: Int = 0, month: Int = 0, day: Int = 0, hour: Int = 0, minute: Int = 0, second: Int = 0) -> Date {
        let calendar = Calendar.current
        
        var comps = DateComponents()
        comps.year = year
        comps.month = month
        comps.day = day
        comps.hour = hour
        comps.minute = minute
        comps.second = second
        
        return calendar.date(byAdding: comps, to: date as Date)!
    }
    
    
    
    public static func years(minDate: Date, maxDate: Date) -> Int {
        assert(minDate <= maxDate, "minDate > maxDate")
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: minDate, to: maxDate)
        return components.year!
    }
    
    
    
    public static func dateByAddingYears(_ year: Int, toDate: Date) -> Date {
        return dateByAdding(toDate: toDate, year: year)
    }
    
    
    
    public static func months(minDate: Date, maxDate: Date) -> Int {
        assert(minDate <= maxDate, "minDate > maxDate")
        
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.month], from: minDate, to: maxDate)
        return components.month!
    }
    
    
    
    public static func dateByAddingMonths(_ month: Int, toDate: Date) -> Date {
        return dateByAdding(toDate: toDate, month: month)
    }
    
    
    
    public static func days(minDate: Date, maxDate: Date) -> Int {
        assert(minDate <= maxDate, "minDate > maxDate")
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.day], from: minDate, to: maxDate)
        return components.day!
    }
    
    
    
    public static func days(range: DateRange) -> Int {
        return days(minDate: range.beginDate, maxDate: range.endDate)
    }
    
    
    
    public static func dateByAddingDays(_ day: Int, toDate: Date) -> Date {
        return dateByAdding(toDate: toDate, day: day)
    }
    
    
    
    public static func hours(minDate: Date, maxDate: Date) -> Int {
        assert(minDate <= maxDate, "minDate > maxDate")
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour], from: minDate, to: maxDate)
        return components.hour!
    }
    
    
    
    public static func minutes(minDate: Date, maxDate: Date, minValue: Int = 0) -> Int {
        assert(minDate <= maxDate, "minDate > maxDate")
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute], from: minDate, to: maxDate)
        
        return max(components.minute!, minValue)
    }
    
    
    
    public static func minutesBeforeNow(_ date: Date, minValue: Int = 0) -> Int {
        return minutes(minDate: date, maxDate: Date(), minValue: minValue)
    }
    
    
    
    public static func minutesAfterNow(_ date: Date, minValue: Int = 0) -> Int {
        return minutes(minDate: Date(), maxDate: date, minValue: minValue)
    }
    
    
    
    public static func dateByAddingSeconds(_ second: Int, toDate: Date) -> Date {
        return dateByAdding(toDate: toDate, second: second)
    }
}
