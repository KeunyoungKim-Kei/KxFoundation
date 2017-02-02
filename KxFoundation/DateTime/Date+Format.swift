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

fileprivate let privateFormatter = DateFormatter()

public extension Date {
    public func format(_ format: String = "yyyyMMdd") -> String {
        privateFormatter.dateFormat = format
        return privateFormatter.string(from: self)
    }
    
    
    
    public func toLocalizedString(_ format: String, locale: Locale = Locale.current, timeZone: TimeZone = TimeZone.current) -> String {
        let currentLocale = privateFormatter.locale
        let currentTimeZone = privateFormatter.timeZone
        
        privateFormatter.locale = locale
        privateFormatter.timeZone = timeZone
        privateFormatter.dateFormat = format
        let result = privateFormatter.string(from: self)
        
        privateFormatter.locale = currentLocale
        privateFormatter.timeZone = currentTimeZone
        
        return result
    }
    
    
    
    public func toStyledString(_ style: DateFormatter.Style) -> String {
        privateFormatter.dateStyle = style
        return privateFormatter.string(from: self)
    }
    
    
    
    public func toStyledString(dateStyle dStyle: DateFormatter.Style, timeStyle tStyle: DateFormatter.Style) -> String {
        privateFormatter.dateStyle = dStyle
        privateFormatter.timeStyle = tStyle
        return privateFormatter.string(from: self)
    }
}
