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

public extension String {
    public struct Regex {
        public static let email = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
        public static let url = "^(((http|https|ftp):\\/\\/)?([[a-zA-Z0-9]\\-\\.])+(\\.)([[a-zA-Z0-9]]){2,4}([[a-zA-Z0-9]\\/+=%&_\\.~?\\-#]*))*$" //"^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$"
        public static let IPv4 = "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
        public static let IPv6 = "^(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]).){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]).){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))$"
        public static let htmlTag = "^<([a-z]+)([^<]+)*(?:>(.*)<\\/\\1>|\\s+\\/>)$"
        public static let creditCard = "^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|6(?:011|5[0-9]{2})[0-9]{12}|(?:2131|1800|35\\d{3})\\d{11})$"
        //public static let securePassword = "^.*(?=^.{8,30}$)(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[!@#$%^&*_\\)\\(+=|}{\\]\\[\\'\\":;><.,?/]).*$"
        
        public struct Korean {
            public static let onlyHangeul = "^[가-힣\\s]+$"
            public static let phoneNumber = "^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$"
            public static let mobileNumber = "^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$"
            public static let zipCode = "^\\d{3}-?\\d{3}$"
            public static let ssn = "^\\d{2}[0-1]\\d[0-3]\\d-?[1-6]\\d{6}$"
            
            private init() { }
        }
        
        public struct US {
            public static let postalAddress = "[a-zA-Z\\d\\s\\-\\,\\#\\.\\+]+"
            public static let visaCreditCard = "^(4[0-9]{12}(?:[0-9]{3})?)*$"
            public static let zipCode = "^\\d{5,6}(?:[-\\s]\\d{4})?$"
            public static let ssn = "^\\d{3}-\\d{2}-\\d{4}$"
            
            private init() { }
        }
        
        private init() { }
    }
    
    public func matches(with pattern: String) -> Bool {
        if String.isNullOrEmpty(self) || String.isNullOrEmpty(pattern) {
            return false
        }
        
        
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let matchCount = regex.numberOfMatches(in: self, options: [], range: entireNSRange)
            print(self, matchCount)
            return matchCount == 1
            
        } catch {
            print(error)
        }
        
        return false
    }
    
    public func replacing(pattern: String, with: String) -> String {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let buffer = NSMutableString(string: self)
            regex.replaceMatches(in: buffer, options: [], range: entireNSRange, withTemplate: with)
            return buffer as String
        } catch {
            print(error)
        }
        
        return self
    }
}
