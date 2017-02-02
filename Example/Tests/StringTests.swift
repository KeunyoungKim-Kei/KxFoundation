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

import XCTest
import KxFoundation

class StringTests: XCTestCase {
    
    func testLeadingCharCount() {
        var source = "       str"
        var cnt = source.leadingCharCount()
        XCTAssertEqual(cnt, 7)
        
        source = "str"
        cnt = source.leadingCharCount()
        XCTAssertEqual(cnt, 0)
    }
    
    
    func testTrailingCharCount() {
        var source = "str"
        var cnt = source.trailingCharCount()
        XCTAssertEqual(cnt, 0)
        
        source = "str   "
        cnt = source.trailingCharCount()
        XCTAssertEqual(cnt, 3)
    }
    
    func testTrim() {
        let charSet = CharacterSet.whitespaces
        let source = "        t r i m        "
        var result = source.trim()
        XCTAssertEqual("t r i m", result)
        
        result = source.trim(position: .start)
        XCTAssertEqual("t r i m        ", result)
        
        result = source.trim(charactersIn: charSet, position: .start)
        XCTAssertEqual("t r i m        ", result)
        
        result = source.trim(charactersIn: charSet, position: .end)
        XCTAssertEqual("        t r i m", result)
        
        result = source.trim(charactersIn: charSet, position: .startAndEnd)
        XCTAssertEqual("t r i m", result)
        
        result = source.trim(charactersIn: charSet, position: .all)
        XCTAssertEqual("trim", result)
    }
    
    
    
    func testChosung() {
        let test = "애플 아이폰"
        if let chosung = test.chosungOfChar() {
            XCTAssertEqual("ㅇ", chosung)
        } else {
            XCTFail()
        }
        
        if let chosung = test.chosungOfChar(at: 1) {
            XCTAssertEqual("ㅍ", chosung)
        } else {
            XCTFail()
        }
        
        if let chosung = test.chosungOfChar(at: 3) {
            XCTAssertEqual("ㅇ", chosung)
        } else {
            XCTFail()
        }
        
        if let chosung = test.chosungOfChar(at: 4) {
            XCTAssertEqual("ㅇ", chosung)
        } else {
            XCTFail()
        }
        
        if let chosung = test.chosungOfChar(at: 5) {
            XCTAssertEqual("ㅍ", chosung)
        } else {
            XCTFail()
        }
    }
    
    func testRange() {
        let source = "Apple 아이폰"
        XCTAssertEqual("A", source[0])
        XCTAssertEqual("pple", source[1 ..< 5])
        XCTAssertEqual("아", source[6])
    }
    
    let validEmail = ["asdfalf@asldfjaf.com", "asdflaf@asdfl.co.kr"]
    let invalidEmail = ["asdflk@asdfl,com", "asldf_2314l@asdfl.co_uk"]
    
    func testEmailRegex() {
        for str in validEmail {
            XCTAssertTrue(str.matches(with: String.Regex.email))
        }
        
        for str in invalidEmail {
            XCTAssertFalse(str.matches(with: String.Regex.email))
        }
    }
    
    let validUrl = ["www.apple.com/kr", "http://www.naver.com", "http://www.daum.net", "http://www.google.com", "http://www.apple.com/kr/shop/buy-iphone/iphone-7#01"]
    let invalidUrl = ["http:/www.apple.com", "http;//www.apple.com"]
    
    func testUrlRegex() {
        for str in validUrl {
            XCTAssertTrue(str.matches(with: String.Regex.url))
        }
        
        for str in invalidUrl {
            XCTAssertFalse(str.matches(with: String.Regex.url))
        }
    }
    
    let validIPv4 = ["127.0.0.1"]
    let invalidIPv4 = ["927.0.0.1"]
    
    func testIPv4Regex() {
        for str in validIPv4 {
            XCTAssertTrue(str.matches(with: String.Regex.IPv4))
        }
        
        for str in invalidIPv4 {
            XCTAssertFalse(str.matches(with: String.Regex.IPv4))
        }
    }
    
    let validIPv6 = ["2001:0DB8:0000:0000:0000:0000:1428:57ab",
                     "2001:0DB8:0000:0000:0000::1428:57ab",
                     "2001:0DB8:0:0:0:0:1428:57ab",
                     "2001:0DB8:0::0:1428:57ab",
                     "2001:0DB8::1428:57ab"]
    let invalidIPv6 = ["127.0.0.1"]
    
    func testIPv6Regex() {
        for str in validIPv6 {
            XCTAssertTrue(str.matches(with: String.Regex.IPv6))
        }
        
        for str in invalidIPv6 {
            XCTAssertFalse(str.matches(with: String.Regex.IPv6))
        }
    }
}
