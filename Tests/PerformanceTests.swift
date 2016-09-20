import XCTest
@testable import Curator

class PerformanceTests: XCTestCase {
    typealias Location = Curator.KeyLocation
    
    let uuidString: String = {
        let uuidString = UUID().uuidString
        let testDirLocation = Location(key: uuidString, directory: .tmp)
        let testDirURL = try! testDirLocation.standardizedFileURL().crt.getDirectoryURL(greedy: true)
        XCTAssertFalse(testDirURL.crt.fileExist.fileExist)
        try! testDirURL.crt.createDirectory()
        XCTAssertTrue(testDirURL.crt.fileExist.isDirectory)
        return uuidString
    }()
    
    func testSave() {
        let data = Data(count: 100)
        let uuidString = self.uuidString
        self.measure {
            let fileName = UUID().uuidString
            let location = Location(key: "\(uuidString)/\(fileName)", directory: .tmp)
            try! Curator.save(data, to: location)
        }
    }
    
    func testGet() {
        let data = Data(count: 1000)
        let location = Location(key: "\(uuidString)/\(UUID().uuidString)", directory: .tmp)
        try! Curator.save(data, to: location)
        
        self.measure {
            let _ = try! Curator.getData(from: location, options: .uncached)
        }
    }
}
