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

open class ApiResponseParameter: ApiParameter {
    static var internalErrorMsg: String!
    
    open var responseDictionary: ApiDictionary
    
    public init?(dict: ApiDictionary?) {
        guard let dict = dict else { return nil }
        responseDictionary = dict
        
        super.init()
        
        printLog()
    }
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - Validation
    
    open var keyList: [String] {
        return [String]()
    }
    
    open var ignoreKeyList: [String] {
        return [String]()
    }
    
    open func validate() -> Bool {
        let dict = responseDictionary
        
        let keyListToCheck = keyList.filter { (key) -> Bool in
            return !ignoreKeyList.contains(key)
        }
        
        return validate(keyList: keyListToCheck, in: [dict])
    }
    
    open func validate(keyList: [String], in dictList: [[String: Any]]) -> Bool {
        let keysInResponse = responseDictionary.keysForApiValidation()
        let requiredKeys = Set(keyList)
        
        return requiredKeys.isSubset(of: keysInResponse)
    }
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: -
    
    open func string(forKey key: String) -> String? {
        return responseDictionary[key] as? String
    }
    
    open func array(forKey key: String) -> ApiDictionaryList? {
        return responseDictionary[key] as? ApiDictionaryList
    }
    
    open func integer(forKey key: String) -> Int? {
        return responseDictionary[key] as? Int
    }
    
    open func dictionary(forKey key: String) -> ApiDictionary? {
        return responseDictionary[key] as? ApiDictionary
    }
    
    
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - Log
        
    open override var description: String {
        let dict = responseDictionary
        
        var maxLength = 10
        for (key, _) in dict {
            maxLength = max(maxLength, key.characters.count)
        }
        
        var buffer = "\(logSeparator)\n"
        let className = NSStringFromClass(self.classForCoder) as String
        buffer.append("\(className) \n")
        buffer.append("\(logSeparator)\n")
        buffer.append(dictionaryDebugString(dict: dict))
        buffer.append("\n\(logSeparator)\n\n")
        
        return buffer
    }
    
    open func dictionaryDebugString(dict: [String: Any], padding: Int = 0) -> String {
        let keys = dict.keys.sorted()
        
        var maxLength = 10
        for (key, _) in dict {
            maxLength = max(maxLength, key.characters.count)
        }
        
        let list = keys.map { (key) -> String in
            let paddingStr = "".padding(toLength: padding + (padding > 0 ? 3 : 0), withPad: " ", startingAt: 0)
            let keyStr = key.padding(toLength: maxLength, withPad: " ", startingAt: 0)
            var result = "\(paddingStr)\(keyStr) : \(valueDebugString(value: dict[key]))"
            
            if let dictValue = dict[key] as? ApiDictionary {
                result = "\(paddingStr)\(keyStr) : ** [Dictionary] \(dictValue.count) keys **\n"
                result += dictionaryDebugString(dict: dictValue, padding: padding + maxLength)
            } else if let arrayValue = dict[key] as? [Any] {
                result = "\(paddingStr)\(keyStr) : ** [Array] \(arrayValue.count) elements **\n"
                result += arrayDebugString(array: arrayValue, padding: padding + maxLength)
            }
            
            return result
        }
        
        if list.count > 0 {
            return list.joined(separator: "\n")
        }
        
        return ""
    }
    
    open func arrayDebugString(array: [Any], padding: Int = 0) -> String {
        let list = array.map { item -> String in
            if let dict = item as? ApiDictionary {
                let paddingStr = "".padding(toLength: padding + 5, withPad: " ", startingAt: 0)
                let result = "\n\(paddingStr) ** [Dictionary] \(dict.count) keys **\n"
                
                return result + dictionaryDebugString(dict: dict, padding: padding + 5)
            }
            
            if let array = item as? [Any] {
                return arrayDebugString(array: array, padding: padding)
            }
            
            return ""
        }
        
        if list.count > 0 {
            return list.joined(separator: "\n")
        }
        
        return ""
    }
    
    open func valueDebugString(value: Any?) -> String {
        if let intValue = value as? Int {
            return "\(intValue)"
        }
        
        if let strValue = value as? String {
            if strValue.characters.count > 0 {
                return "\"\(strValue)\""
            }
            
            return "** empty string **"
        }
        
        return "** nil **"
    }
}
