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
    
    func testFileExist() {
        let tmpDirURL = Curator.SupportedDirectory.tmp.url
        let tmpDirExistResult = tmpDirURL.crt.fileExist
        XCTAssertTrue(tmpDirExistResult.fileExist)
        XCTAssertTrue(tmpDirExistResult.isDirectory)
        
        let notExistFileURL = URL(string: "file:///notExistFile")!
        let notExistFileExistResult = notExistFileURL.crt.fileExist
        XCTAssertFalse(notExistFileExistResult.fileExist)
        XCTAssertFalse(notExistFileExistResult.isDirectory)
        
        let hostsFileURL = URL(string: "file:///etc/hosts")!
        let hostsFileExistResult = hostsFileURL.crt.fileExist
        XCTAssertTrue(hostsFileExistResult.fileExist)
        XCTAssertFalse(hostsFileExistResult.isDirectory)
    }
    
    func testCreateDirectory() {
        //create testDir first
        let uuidString = UUID().uuidString
        typealias Location = Curator.KeyLocation
        let testDirLocation = Location(key: uuidString, directory: .tmp)
        let testDirURL = try! testDirLocation.standardizedFileURL().crt.getDirectoryURL(greedy: true)
        XCTAssertFalse(testDirURL.crt.fileExist.fileExist)
        try! testDirURL.crt.createDirectory()
        XCTAssertTrue(testDirURL.crt.fileExist.isDirectory)
        
        //save a file for test
        let data = Data(count: 1)
        let fileLocation = Location(key: "\(uuidString)/file", directory: .tmp)
        try! Curator.save(data, to: fileLocation)
        let fileLocationURL = try! fileLocation.standardizedFileURL()
        XCTAssertTrue(fileLocationURL.crt.fileExist.fileExist)
        
        //check locationIsFile
        let fileLocationFakeDirURL = fileLocationURL.crt.getDirectoryURL(greedy: true)
        do {
            try fileLocationFakeDirURL.crt.createDirectory()
            XCTFail()
        } catch Curator.Error.locationIsFile(let location) {
            let url = location as! URL
            XCTAssertEqual(url, fileLocationFakeDirURL)
        } catch { XCTFail() }
        
        //check parent locationIsFile
        let fileLocation2 = Location(key: "\(uuidString)/file/dir/dir/foo", directory: .tmp)
        let fileLocation2URL = try! fileLocation2.standardizedFileURL()
        XCTAssertFalse(fileLocation2URL.crt.fileExist.fileExist)
        do {
            try fileLocation2URL.crt.createDirectory()
            XCTFail()
        } catch Curator.Error.locationIsFile(let location) {
            let url = location as! URL
            XCTAssertEqual(url, fileLocationFakeDirURL)
        } catch { XCTFail() }
        
        //reuse fileExistResult
        let testDirExistResult = testDirURL.crt.fileExist
        try! testDirURL.crt.createDirectory(fileExistResult: testDirExistResult)
    }
}
