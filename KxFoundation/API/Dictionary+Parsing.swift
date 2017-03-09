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

public extension Dictionary {
    public func array(forKey key: Key) -> ApiDictionaryList? {
        return self[key] as? ApiDictionaryList
    }
    
    public func string(forKey key: Key, allowConversion: Bool = true) -> String? {
        if let value = self[key], allowConversion {
            return String(describing: value)
        }
        
        return self[key] as? String
    }
    
    public func integer(forKey key: Key, allowConversion: Bool = true) -> Int? {
        if let value = self[key], allowConversion {
            switch value {
            case let stringValue as String:
                if let result = Int(stringValue) {
                    return result
                }
            case let dblValue as Double:
                return Int(dblValue)
            case let fltValue as Float:
                return Int(fltValue)
            default:
                break
            }
        }
        
        return self[key] as? Int
    }
    
    public func bool(forKey key: Key, allowConversion: Bool = true) -> Bool {
        if let value = self[key], allowConversion {
            switch value {
            case let strValue as String:
                let list = ["y", "t", "true", "yes", "1"]
                for literal in list {
                    if strValue.lowercased() == literal {
                        return true
                    }
                }
            case let intValue as Int:
                return intValue != 0
            default:
                break
            }
        }
        
        return self[key] as? Bool ?? false
    }
    
    public func url(forKey key: Key) -> URL? {
        if let str = self[key] as? String, let url = URL(string: str) {
            return url
        }
        
        return nil
    }
    
    public func keysForApiValidation(of dict: Dictionary<AnyHashable, Any>? = nil, key: String? = nil) -> Set<String> {
        var result = Set<String>()
        
        var target = dict
        if target == nil {
            target = self
        }
        
        var keyStr = ""
        if let key = key {
            keyStr = "\(key)-"
        }
        
        if let target = target {
            for elem in target {
                if let d = elem.value as? Dictionary<AnyHashable, Any> {
                    result.insert(keyStr + (elem.key as! String))
                    result.formUnion(keysForApiValidation(of: d, key: keyStr + (elem.key as! String)))
                } else if let array = elem.value as? Array<Any> {
                    result.insert(keyStr + (elem.key as! String))
                    for item in array {
                        if let d = item as? Dictionary<AnyHashable, Any> {
                            result.formUnion(keysForApiValidation(of: d, key: keyStr + (elem.key as! String)))
                        }
                        else if let s = item as? String {
                            if let key = key {
                                result.insert(keyStr + "\(elem.key as! String)")
                            } else {
                                result.insert(keyStr)
                            }
                        }
                    }
                } else {
                    if let key = key {
                        result.insert("\(key)-" + (elem.key as! String))
                    } else {
                        result.insert(elem.key as! String)
                    }
                }
            }
        }
        
        return result
    }
}
