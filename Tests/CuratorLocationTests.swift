import XCTest
@testable import Curator

class CuratorLocationTests: XCTestCase {
    func testStandardizedFileURL() {
        let keyLocation = Curator.KeyLocation(key: "file", directory: .tmp)
        let keyLocationStandardizedFileURL = try! keyLocation.standardizedFileURL()
        let keyLocationURL = try! keyLocation.asURL()
        XCTAssertEqual(keyLocationURL, keyLocationStandardizedFileURL)
        
        let webURL = URL(string: "https://apple.com")!
        do {
            let _ = try webURL.standardizedFileURL()
        } catch Curator.Error.unableToConvertToFileURL(_) {}
        catch { XCTFail() }
        
        
        let emptyPathURL = URL(string: "file://user:password@localhost")!
        do {
            let _ = try emptyPathURL.standardizedFileURL()
        } catch Curator.Error.invalidLocation(_) {}
        catch { XCTFail() }
    }
    
    func testKeyLocationEquatable() {
        typealias Location = Curator.KeyLocation
        XCTAssertEqual(Location(key: "foo", directory: .tmp), Location(key: "foo", directory: .tmp))
        XCTAssertNotEqual(Location(key: "foo", directory: .tmp), Location(key: "bar", directory: .tmp))
        XCTAssertNotEqual(Location(key: "foo", directory: .tmp), Location(key: "foo", directory: .caches))
        XCTAssertNotEqual(Location(key: "foo", directory: .tmp), Location(key: "bar", directory: .caches))
    }
}
