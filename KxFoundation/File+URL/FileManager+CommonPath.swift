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

public extension FileManager {
    /////////////////////////////////////////////////////////////////////
    //
    // MARK: - Commonly Used Directories
    //
    static var documentsDirectoryURL: URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls.last!
    }
    
    
    
    static var libraryDirectoryURL: URL {
        let urls = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)
        return urls.last!
    }
    
    
    
    static var applicationSupportDirectoryURL: URL {
        let urls = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)
        return urls.last!
    }
    
    
    
    static var cacheDirectoryURL: URL {
        let urls = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return urls.last!
    }
    
    
    
    static var temporaryDirectoryURL: URL {
        return URL(fileURLWithPath: NSTemporaryDirectory())
    }
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - 
    
    static func cacheDirectoryPath() -> String? {
        let list = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        if list.count > 0 {
            return list.last
        }
        
        return nil
    }
    
    
    
    static func documentDirectoryPath() -> String? {
        let list = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        if list.count > 0 {
            return list.last
        }
        
        return nil
    }
}
