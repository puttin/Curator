import XCTest
import Curator

class SupportedDirectoryTests: XCTestCase {
    func testURL() {
        let documentDirURL = Curator.SupportedDirectory.documents.url
        XCTAssertTrue(documentDirURL.absoluteString.hasSuffix("Documents/"))
        
        let cachesDirURL = Curator.SupportedDirectory.caches.url
        XCTAssertTrue(cachesDirURL.absoluteString.hasSuffix("Caches/"))
        
        let applicationSupportDirURL = Curator.SupportedDirectory.applicationSupport.url
        let applicationSupportSuffix = "Application Support/".addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
        XCTAssertTrue(applicationSupportDirURL.absoluteString.hasSuffix(applicationSupportSuffix))
        
        let tmpDirURL = Curator.SupportedDirectory.tmp.url
        XCTAssertTrue(tmpDirURL.absoluteString.hasSuffix("tmp/"))
    }
}
