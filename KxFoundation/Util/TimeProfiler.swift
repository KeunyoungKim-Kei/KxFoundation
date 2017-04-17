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

public struct TimeProfiler {
    static var shared = TimeProfiler()
    
    var checkPoints = [(tag: String, time: TimeInterval)]()
    
    
    public static func start() {
        shared.checkPoints.removeAll()
        shared.checkPoints.append(("Start", Date.timeIntervalSinceReferenceDate))
    }
    
       
    public static func checkPoint(tag: String? = nil) {
        if shared.checkPoints.count == 0 {
            start()
            return
        }
        
        let checkPointTag = tag ?? "Checkpoint \(shared.checkPoints.count)"
        shared.checkPoints.append((checkPointTag, Date.timeIntervalSinceReferenceDate))
    }
    
    
    
    public static func report(verbose: Bool = false, funcationName: String = #function) {
        if shared.checkPoints.count < 1 {
            print("TimeProfiler: Nothing to report. Start new session!")
            return
        }
        
        shared.checkPoints.append(("End", Date.timeIntervalSinceReferenceDate))
        
        let start = shared.checkPoints.first!.time
        let end = shared.checkPoints.last!.time
        
        let total = String(format: "%.6f", end - start)
        print("TimeProfiler: \(funcationName) in \(total)s")
        
        if verbose {
            var maxLength = 15
            for item in shared.checkPoints {
                maxLength = max(item.tag.characters.count, maxLength)
            }
            
            print("==================================================")
            for index in 0..<shared.checkPoints.count {
                let item = shared.checkPoints[index]
                
                var tag = item.tag
                if tag.characters.count < maxLength {
                    tag = item.tag.padding(toLength: maxLength, withPad: " ", startingAt: 0)
                }
                
                if item == shared.checkPoints.first! {
                    print("\(tag)  0")
                } else {
                    let prev = shared.checkPoints[index - 1]
                    
                    let time = String(format: "%.6f", item.time - prev.time)
                    print("\(tag) +\(time)")
                }
            }
            print("==================================================")
            print("\("total".padding(toLength: maxLength, withPad: " ", startingAt: 0))  \(total)")
            print("==================================================")
        }
        
        shared.checkPoints.removeAll()
    }
}
