import XCTest
@testable import Curator

class UtilityTests: XCTestCase {
    func testFileManager() {
        let fileManager = CuratorFileManager
        let defaultFileManager = FileManager.default
        XCTAssertNotEqual(fileManager, defaultFileManager)
    }
    
    func testURLComponents_CuratorLocation() {
        var goodURLComponents = URLComponents()
        goodURLComponents.scheme = "file"
        goodURLComponents.host = ""
        goodURLComponents.path = "/file"
        let _ = try! (goodURLComponents as CuratorLocation).asURL()
        
        var badURLComponents = URLComponents()
        badURLComponents.path = "//"
        do {
            let _ = try (badURLComponents as CuratorLocation).asURL()
            XCTFail()
        } catch Curator.Error.invalidLocation(_) {}
        catch { XCTFail() }
    }
    
    func testKeepableExtension() {
        let data = Data(count: 100)
        try! data.crt.save(to: "\(UUID().uuidString)", in: .tmp)
    }
    
    func testCuratorEasyGetData() {
        let data = Data(count: 100)
        let uuidString = UUID().uuidString
        
        try! data.crt.save(to: uuidString, in: .tmp)
        let _ = try! Curator.getData(of: uuidString, in: .tmp)
    }
}
