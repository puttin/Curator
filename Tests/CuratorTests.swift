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
    
    func testGet() {
        let data = Data(count: 100)
        let fileName = UUID().uuidString
        let location = Location(key: "\(uuidString)/\(fileName)", directory: .tmp)
        try! Curator.save(data, to: location)
        
        let dataGetted = try! Curator.getData(from: location)
        XCTAssertEqual(data, dataGetted)
        
        do {
            let _ = try Curator.getData(from: Curator.SupportedDirectory.tmp.url)
        } catch Curator.Error.locationIsDirectory(_) {}
        catch { XCTFail() }
        
        do {
            let notExistFileLocation = Location(key: "\(uuidString)/notExistFile", directory: .tmp)
            let _ = try Curator.getData(from: notExistFileLocation)
        } catch Curator.Error.locationFileNotExist(_) {}
        catch { XCTFail() }
    }
    
    func testDelete() {
        let data = Data(count: 100)
        let fileName = UUID().uuidString
        let location = Location(key: "\(uuidString)/\(fileName)", directory: .tmp)
        try! Curator.save(data, to: location)
        
        try! Curator.delete(location: location)
        
        do {
            try Curator.delete(location: location)
        } catch Curator.Error.locationFileNotExist(_) {}
        catch { XCTFail() }
        
        let dirLocation = Location(key: "\(uuidString)/dir", directory: .tmp)
        try! Curator.createDirectory(at: dirLocation)
        
        do {
            try Curator.delete(location: dirLocation)
        } catch Curator.Error.locationIsDirectory(_) {}
        catch { XCTFail() }
        
        try! Curator.delete(
            location: dirLocation,
            allowDirectory: true
        )
    }
}
