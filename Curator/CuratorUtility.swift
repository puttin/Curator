import Foundation

let CuratorFileManager = FileManager()

extension URL: CuratorLocation {
    public func asURL() throws -> URL {
        return self
    }
}

extension URLComponents: CuratorLocation {
    public func asURL() throws -> URL {
        guard let url = url else { throw Curator.Error.invalidLocation(self) }
        return url
    }
}

extension Data: CuratorKeepable {
    public func asData() throws -> Data {
        return self
    }
}

//MARK: Curator Extension for URL

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
            if base.lastPathComponent.hasSuffix("/") {
                return true
            }
            return false
        }
    }
}
