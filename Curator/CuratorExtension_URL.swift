import Foundation

extension URL {
    var crt: CuratorExtension<URL> {
        return CuratorExtension(self)
    }
}

extension CuratorExtensionProtocol where Base == URL {
    var hasDirectoryPath: Bool {
        if #available(iOS 9.0, OSX 10.11, *) {
            return base.hasDirectoryPath
        } else {
            let url = base.standardized
            let absoluteString = url.absoluteString
            let lastPathComponent = url.lastPathComponent
            let lastRange = absoluteString.range(of: lastPathComponent, options: .backwards)!
            
            if absoluteString.substring(from: lastRange.upperBound).hasPrefix("/") {
                return true
            }
            return false
        }
    }
    
    func getDirectoryURL(greedy: Bool = false) -> URL {
        var url = base
        if url.crt.hasDirectoryPath {
            return url
        }
        
        if greedy {
            url.appendPathComponent("/")
        }
        else {
            url.deleteLastPathComponent()
        }
        
        return url
    }
}

extension Curator {
    struct FileExistResult {
        let fileExist: Bool
        let isDirectory: Bool
    }
}

extension CuratorExtensionProtocol where Base == URL {
    var fileExist: Curator.FileExistResult {
        //here we assume url gets from CuratorLocation.standardizedFileURL() throws
        let url = base
        var isDirectory: ObjCBool = false
        let fileExist = CuratorFileManager.fileExists(atPath: url.path, isDirectory: &isDirectory)
        return Curator.FileExistResult(
            fileExist: fileExist,
            isDirectory: isDirectory.boolValue
        )
    }
    
    func createDirectory(
        fileExistResult _urlFileExistResult: Curator.FileExistResult? = nil
        ) throws {
        //here we assume url gets from CuratorLocation.standardizedFileURL() throws
        let url = base
        let directoryURL = url.crt.getDirectoryURL()
        
        typealias FileExistResult = Curator.FileExistResult
        let directoryExistResult: FileExistResult
        if let urlFileExistResult = _urlFileExistResult,
            url == directoryURL {
            directoryExistResult = urlFileExistResult
        }
        else {
            directoryExistResult = directoryURL.crt.fileExist
        }
        
        if directoryExistResult.fileExist {
            if directoryExistResult.isDirectory {
                return
            }
            throw Curator.Error.locationIsFile(directoryURL)
        }
        
        //check parentDir
        var parentDirectoryURL = directoryURL.deletingLastPathComponent()
        while true {
            let parentDirExistResult = parentDirectoryURL.crt.fileExist
            if parentDirExistResult.fileExist {
                if parentDirExistResult.isDirectory {
                    break
                }
                throw Curator.Error.locationIsFile(parentDirectoryURL)
            }
            
            parentDirectoryURL.deleteLastPathComponent()
        }
        
        try CuratorFileManager.createDirectory(
            at: directoryURL,
            withIntermediateDirectories: true
        )
    }
}
