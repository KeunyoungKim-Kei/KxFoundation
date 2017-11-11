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

open class ApiRequestParameter: ApiParameter {
    override public init() {
        super.init()
    }
    
    open var uri: ApiRequestUri {
        fatalError("Override this!!")
    }
    
    open var plain: ApiDictionary {
        return ApiDictionary()
    }
    
    open var encrypted: ApiDictionary? {
        return nil
    }
    
    open var urlString: String {
        fatalError("Override this!!")
    }
     
    open override var description: String {
        var maxLength = 10
        for (key, _) in plain {
         #if swift(>=3.2)
            maxLength = max(maxLength, key.count)
         #else
            maxLength = max(maxLength, key.characters.count)
         #endif
        }
        
        var buffer = "\(logSeparator)\n"
        let className = NSStringFromClass(self.classForCoder) as String
        buffer.append("\(className)\n")
        buffer.append("\(logSeparator)\n")
        for key in plain.keys.sorted() {
            buffer.append("\(key.padding(toLength: maxLength, withPad: " ", startingAt: 0)) : \(plain[key]!)\n")
        }
        if plain.count == 0 {
            buffer.append("** empty **\n")
        }
        buffer.append("\(logSubSeparator)\n")
        buffer.append("URI: \(uri.uriString)\n")
        buffer.append("\(logSeparator)\n\n")
        
        return buffer
    }
}
