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
