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
