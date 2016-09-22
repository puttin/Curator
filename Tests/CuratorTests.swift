import XCTest
import Curator

class CuratorTests: XCTestCase {
    typealias Location = Curator.KeyLocation
    
    let uuidString: String = {
        let uuidString = UUID().uuidString
        let testDirLocation = Location(key: uuidString, directory: .tmp)
        try! Curator.createDirectory(at: testDirLocation)
        return uuidString
    }()
    
    func testSave() {
        let data = Data(count: 100)
        let fileName = UUID().uuidString
        let location = Location(key: "\(uuidString)/\(fileName)", directory: .tmp)
        try! Curator.save(data, to: location)
        
        //normally it should allow overwriting
        try! Curator.save(data, to: location)
        
        do {
            try Curator.save(data, to: location, options: .withoutOverwriting)
        } catch Curator.Error.locationFileExist(_) {}
        catch { XCTFail() }
        
        do {
            try Curator.save(data, to: Curator.SupportedDirectory.tmp.url)
        } catch Curator.Error.locationIsDirectory(_) {}
        catch { XCTFail() }
    }
}
