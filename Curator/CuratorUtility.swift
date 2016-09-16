import Foundation

let CuratorFileManager = FileManager()

extension URL: CuratorLocation {
    public func asURL() throws -> URL {
        return self
    }
}

extension URLComponents: CuratorLocation {
    public func asURL() throws -> URL {
        guard let url = url else { throw CuratorError.invalidURL(url: self) }
        return url
    }
}
