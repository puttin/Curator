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
            XCTFail()
        } catch Curator.Error.locationFileExist(_) {}
        catch { XCTFail() }
        
        do {
            try Curator.save(data, to: Curator.SupportedDirectory.tmp.url)
            XCTFail()
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
            XCTFail()
        } catch Curator.Error.locationIsDirectory(_) {}
        catch { XCTFail() }
        
        do {
            let notExistFileLocation = Location(key: "\(uuidString)/notExistFile", directory: .tmp)
            let _ = try Curator.getData(from: notExistFileLocation)
            XCTFail()
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
            XCTFail()
        } catch Curator.Error.locationFileNotExist(_) {}
        catch { XCTFail() }
        
        let dirLocation = Location(key: "\(uuidString)/dir", directory: .tmp)
        try! Curator.createDirectory(at: dirLocation)
        
        do {
            try Curator.delete(location: dirLocation)
            XCTFail()
        } catch Curator.Error.locationIsDirectory(_) {}
        catch { XCTFail() }
        
        try! Curator.delete(
            location: dirLocation,
            allowDirectory: true
        )
    }
    
    func testMove() {
        let data = Data(count: 100)
        let fileName1 = UUID().uuidString
        let location1 = Location(key: "\(uuidString)/\(fileName1)", directory: .tmp)
        try! Curator.save(data, to: location1)
        
        try! Curator.move(from: location1, to: location1)
        
        let fileName2 = UUID().uuidString
        let location2 = Location(key: "\(uuidString)/\(fileName2)", directory: .tmp)
        try! Curator.move(from: location1, to: location2)
        
        do {
            let fileName2 = UUID().uuidString
            let location2 = Location(key: "\(uuidString)/\(fileName2)", directory: .tmp)
            try Curator.move(from: location1, to: location2)
            XCTFail()
        } catch Curator.Error.locationFileNotExist(_) {}
        catch { XCTFail() }
        
        try! Curator.save(data, to: location1)
        
        do {
            try Curator.move(from: location1, to: location2)
            XCTFail()
        } catch Curator.Error.locationFileExist(_) {}
        catch { XCTFail() }
        
        let dirLocation = Location(key: "\(uuidString)/dir", directory: .tmp, isDirectory: true)
        try! Curator.createDirectory(at: dirLocation)
        
        let dirLocation2 = Location(key: "\(uuidString)/dir2", directory: .tmp)
        
        try! Curator.move(from: dirLocation, to: dirLocation2)
        
        //A test to info me when `mv file dir/` style can be passed
        do {
            try! Curator.createDirectory(at: dirLocation)
            try Curator.move(from: dirLocation, to: dirLocation2)
            XCTFail("the mv style!")
        } catch {}
    }
}
