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

public struct KFKeyValueStore {
    fileprivate static var store: UserDefaults {
        return UserDefaults.standard
    }
    
    
    
    public static func has(key: String) -> Bool {
        return store.object(forKey: key) != nil
    }
    
    
    
    public static func save(value: Any, forKey key: String, saveImmediately: Bool = true) {
        store.set(value, forKey: key)
        
        if saveImmediately {
            store.synchronize()
        }
    }
    
    
    
    public static func value(forKey key: String, defaultValue: Any? = nil) -> Any? {
        guard let existValue = store.object(forKey: key) else {
            if let value = defaultValue {
                save(value: value, forKey: key)
            }
            
            return defaultValue
        }
        
        return existValue
    }
    
    
    
    public static func remove(forKey key: String, saveImmediately: Bool = true) {
        store.removeObject(forKey: key)
        
        if saveImmediately {
            store.synchronize()
        }
    }
    
    
    
    
    /////////////////////////////////////////////////////////////////////
    //
    // MARK: - String
    //
    public static func save(string value: String, forKey key: String, saveImmediately: Bool = true) {
        store.set(value, forKey: key)
        
        if saveImmediately {
            store.synchronize()
        }
    }
    
    
    
    public static func string(forKey key: String, defaultValue: String? = nil) -> String? {
        guard let existValue = store.object(forKey: key) as? String else {
            if let value = defaultValue {
                save(string: value, forKey: key)
            }
            
            return defaultValue
        }
        
        return existValue
    }
    
    
    
    
    /////////////////////////////////////////////////////////////////////
    //
    // MARK: - Number
    //
    public static func number(forKey key: String, defaultValue: NSNumber? = nil) -> NSNumber? {
        guard let existValue = store.object(forKey: key) as? NSNumber else {
            if let value = defaultValue {
                store.set(value, forKey: key)
                store.synchronize()
            }
            
            return defaultValue
        }
        
        return existValue
    }
    
    
    
    public static func save(integer value: Int, forKey key: String, saveImmediately: Bool = true) {
        store.set(value, forKey: key)
        
        if saveImmediately {
            store.synchronize()
        }
    }
    
    
    
    public static func integer(forKey key: String, defaultValue: Int = 0) -> Int {
        guard let existValue = store.object(forKey: key) as? NSNumber else {
            save(integer: defaultValue, forKey: key)
            
            return defaultValue
        }
        
        return existValue.intValue
    }
    
    
    
    public static func save(float value: Float, forKey key: String, saveImmediately: Bool = true) {
        store.set(value, forKey: key)
        
        if saveImmediately {
            store.synchronize()
        }
    }
    
    
    
    public static func float(forKey key: String, defaultValue: Float = 0.0) -> Float {
        guard let existValue = store.object(forKey: key) as? NSNumber else {
            save(float: defaultValue, forKey: key)
            
            return defaultValue
        }
        
        return existValue.floatValue
    }
    
    
    
    public static func save(double value: Double, forKey key: String, saveImmediately: Bool = true) {
        store.set(value, forKey: key)
        
        if saveImmediately {
            store.synchronize()
        }
    }
    
    
    
    public static func double(forKey key: String, defaultValue: Double = 0.0) -> Double {
        guard let existValue = store.object(forKey: key) as? NSNumber else {
            save(double: defaultValue, forKey: key)
            
            return defaultValue
        }
        
        return existValue.doubleValue
    }
    
    
    
    public static func save(cgFloat value: CGFloat, forKey key: String, saveImmediately: Bool = true) {
        save(double: Double(value), forKey: key, saveImmediately: saveImmediately)
    }
    
    
    
    public static func cgFloat(forKey key: String, defaultValue: CGFloat = 0.0) -> CGFloat {
        return CGFloat(double(forKey: key, defaultValue: Double(defaultValue)))
    }
    
    
    
    public static func save(bool value: Bool, forKey key: String, saveImmediately: Bool = true) {
        store.set(value, forKey: key)
        
        if saveImmediately {
            store.synchronize()
        }
    }
    
    
    
    public static func saveTrue(forKey key: String, saveImmediately: Bool = true) {
        save(bool: true, forKey: key, saveImmediately: saveImmediately)
    }
    
    
    
    public static func saveFalse(forKey key: String, saveImmediately: Bool = true) {
        save(bool: false, forKey: key, saveImmediately: saveImmediately)
    }
    
    
    
    public static func bool(forKey key: String, defaultValue: Bool = false) -> Bool {
        guard let existValue = store.object(forKey: key) as? NSNumber else {
            save(bool: defaultValue, forKey: key)
            
            return defaultValue
        }
        
        return existValue.boolValue
    }
    
    
    
    public static func isTrue(forKey key: String, defaultValue: Bool = false) -> Bool {
        return bool(forKey: key, defaultValue: defaultValue) == true
    }
    
    
    
    public static func isFalse(forKey key: String, defaultValue: Bool = false) -> Bool {
        return bool(forKey: key, defaultValue: defaultValue) == false
    }
    
    
    
    
    /////////////////////////////////////////////////////////////////////
    //
    // MARK: - Date
    //
    public static func save(date value: NSDate, forKey key: String, saveImmediately: Bool = true) {
        store.set(value, forKey: key)
        
        if saveImmediately {
            store.synchronize()
        }
    }
    
    
    
    public static func saveNow(forKey key: String, saveImmediately: Bool = true) {
        save(date: NSDate(), forKey: key, saveImmediately: saveImmediately)
    }
    
    
    
    public static func saveToday(forKey key: String, saveImmediately: Bool = true) {
        save(date: NSDate(), forKey: key, saveImmediately: saveImmediately)
    }
    
    
    
    public static func date(forKey key: String, defaultValue: NSDate = NSDate(timeIntervalSince1970: 0)) -> NSDate {
        guard let existValue = store.object(forKey: key) as? Date else {
            save(date: defaultValue, forKey: key)
            
            return defaultValue
        }
        
        return existValue as NSDate
    }
}
