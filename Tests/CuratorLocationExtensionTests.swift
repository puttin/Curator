import XCTest
@testable import Curator

class CuratorLocationExtensionTests: XCTestCase {
    func testCuratorExtension() {
        let keyLocation = Curator.KeyLocation(key: "file", directory: .tmp)
        XCTAssertEqual(keyLocation, keyLocation.crt.base)
    }
    
    func testStandardizedFileURL() {
        let keyLocation = Curator.KeyLocation(key: "file", directory: .tmp)
        let keyLocationStandardizedFileURL = try! keyLocation.crt.standardizedFileURL()
        let keyLocationURL = try! keyLocation.asURL()
        XCTAssertEqual(keyLocationURL, keyLocationStandardizedFileURL)
        
        let webURL = URL(string: "https://apple.com")!
        do {
            let _ = try webURL.crt.standardizedFileURL()
        } catch let error {
            if case Curator.Error.unableToConvertToFileURL(_) = error {}
            else {
                XCTFail()
            }
        }
        
        let emptyPathURL = URL(string: "file://user:password@localhost")!
        do {
            let _ = try emptyPathURL.crt.standardizedFileURL()
        } catch let error {
            if case Curator.Error.invalidLocation(_) = error {}
            else {
                XCTFail()
            }
        }
    }
}
