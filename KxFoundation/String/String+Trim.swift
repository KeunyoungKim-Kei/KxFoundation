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

public enum TrimPosition {
    case start
    case end
    case startAndEnd
    case all
}

public extension String {
    func leadingCharCount(from charSet: CharacterSet = CharacterSet.whitespaces) -> Int {
        var cnt = 0
      
      #if swift(>=3.2)
         for char in self {
            if String(char).rangeOfCharacter(from: charSet) != nil {
               cnt += 1
            } else {
               break
            }
         }
      #else
         for char in characters {
            if String(char).rangeOfCharacter(from: charSet) != nil {
               cnt += 1
            } else {
               break
            }
         }
         
      #endif
        
        return cnt
    }
    
    func trailingCharCount(from charSet: CharacterSet = CharacterSet.whitespaces) -> Int {
        var cnt = 0
      #if swift(>=3.2)
         for char in self.reversed() {
            if String(char).rangeOfCharacter(from: charSet) != nil {
               cnt += 1
            } else {
               break
            }
         }
         #else
        for char in characters.reversed() {
         
            if String(char).rangeOfCharacter(from: charSet) != nil {
                cnt += 1
            } else {
                break
            }
        }
         #endif
        
        return cnt
    }
    
    public func trim(charactersIn charSet: CharacterSet = CharacterSet.whitespaces, position: TrimPosition = .startAndEnd) -> String {
        
        switch position {
        case .start:
            let cnt = leadingCharCount(from: charSet)
            return substring(from: index(startIndex, offsetBy: cnt))
        case .end:
            let cnt = trailingCharCount(from: charSet)
            return substring(to: index(endIndex, offsetBy: cnt * -1))
        case .startAndEnd:
            return trimmingCharacters(in: charSet)
        case .all:
            let list = components(separatedBy: charSet)
            return list.joined(separator: "")
        }
    }
}
