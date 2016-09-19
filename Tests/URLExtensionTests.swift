import XCTest
@testable import Curator

class URLExtensionTests: XCTestCase {
    let fileURL = URL(string: "file:///file")!
    let directoryURL = URL(string: "file:///dir/")!
    
    func testCuratorExtension() {
        XCTAssertEqual(fileURL, fileURL.crt.base)
    }
    
    func testHasDirectoryPath() {
        XCTAssertFalse(fileURL.crt.hasDirectoryPath)
        XCTAssertTrue(directoryURL.crt.hasDirectoryPath)
        
        let directoryCurrentDirURL = directoryURL.appendingPathComponent(".", isDirectory: true)
        let directoryCurrentDirURL2 = directoryURL.appendingPathComponent(".", isDirectory: false)
        XCTAssertTrue(directoryCurrentDirURL.crt.hasDirectoryPath)
        XCTAssertTrue(directoryCurrentDirURL2.crt.hasDirectoryPath)
        
        let webURL = URL(string: "https://api.shop.com/category/toy/../phone/./iphone/?json=true")!
        XCTAssertTrue(webURL.crt.hasDirectoryPath)
    }
    
    func testGetDirectoryURL() {
        XCTAssertEqual(directoryURL, directoryURL.crt.getDirectoryURL(greedy: false))
        XCTAssertEqual(directoryURL, directoryURL.crt.getDirectoryURL(greedy: true))
        
        let rootURL = URL(string: "file:///")!
        XCTAssertEqual(rootURL, fileURL.crt.getDirectoryURL(greedy: false))
        
        let fileDirectoryURL = URL(string: "file:///file/")!
        XCTAssertEqual(fileDirectoryURL, fileURL.crt.getDirectoryURL(greedy: true))
    }
}
