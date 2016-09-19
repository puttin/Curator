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
