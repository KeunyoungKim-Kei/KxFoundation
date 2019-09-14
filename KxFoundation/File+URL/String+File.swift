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
    var fileExtension: String? {
        let str = NSString(string: self)
        let ext = str.pathExtension
        
        if String.isNullOrEmpty(ext) {
            return nil
        }
        
        return ext
    }   
    
    
    
    func isSupportImageFile(_ imageFileExtensions:[String] = ["tiff", "tif", "jpeg", "jpg", "gif", "png", "bmp", "bmpf", "ico", "cur", "xbm"]) -> Bool {
        let str = NSString(string: self)
        let ext = str.pathExtension.lowercased()
        
        for str in imageFileExtensions {
            if str.lowercased() == ext {
                return true
            }
        }
        
        return false
    }
    
    
    
    static func capacityStringFromBytes(_ bytes: UInt64, byteUnitString: String = "Bytes", KBUnitString: String = "KB", MBUnitString: String = "MB", GBUnitString: String = "GB") -> String {
        let minGB: UInt64 = 1024 * 1024 * 1024
        let minMB: UInt64 = 1024 * 1024
        let minKB: UInt64 = 1024
        var unitStr = byteUnitString
        var retStr = ""
        var unitValue: Float = 0.0
        
        if (bytes >= minGB) {
            unitStr = GBUnitString
            unitValue = floorf( ( Float(bytes) / Float(minGB) ) * 10.0 ) * 0.1
        } else if (bytes >= minMB) {
            unitStr = MBUnitString
            unitValue = floorf( ( Float(bytes) / Float(minMB) ) * 10.0 ) * 0.1
        } else if (bytes >= minKB) {
            unitStr = KBUnitString
            unitValue = floorf( ( Float(bytes) / Float(minKB) ) * 10.0 ) * 0.1
        } else {
            unitValue = Float(bytes)
        }
        
        retStr = "\(unitValue)" + unitStr
        
        return retStr
    }
}
