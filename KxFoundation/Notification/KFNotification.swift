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

public enum NotificationQueueType {
    case current
    case main
    case global
}

public struct KFNotification {
    public static func post(rawNotificationName name: String, object: AnyObject? = nil, onQueue queueType: NotificationQueueType = .current) {
        post(name: Notification.Name(rawValue: name), with: object, onQueue: queueType)
    }
    
    public static func post(name: Notification.Name, with object: AnyObject? = nil, onQueue queueType: NotificationQueueType = .current) {
        switch queueType {
        case .main:
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: name, object: object)
            }
        case .global:
            DispatchQueue.global().async {
                NotificationCenter.default.post(name: name, object: object)
            }
        default:
            NotificationCenter.default.post(name: name, object: object)
        }
    }
    
    
    
    public static func postDelayed(onQueue queueType: NotificationQueueType, rawNotificationName name: String, delay: Double = 0.3, object: AnyObject? = nil) {
        postDelayed(onQueue: queueType, name: Notification.Name(rawValue: name), delay: delay, object: object)
    }
    
    
    
    public static func postDelayed(onQueue queueType: NotificationQueueType, name: Notification.Name, delay: Double = 0.3, object: AnyObject? = nil) {
        switch queueType {
        case .main:
            DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: { 
                NotificationCenter.default.post(name: name, object: object)
            })
        case .global:
            DispatchQueue.global().asyncAfter(deadline: .now() + delay, execute: {
                NotificationCenter.default.post(name: name, object: object)
            })
        default:
            fatalError("not support")
        }
    }
}
