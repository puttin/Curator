public protocol CuratorURLConvertible {
    func asURL() throws -> URL
}

public struct CuratorKeyLocation {
    let key: String
    let directory: CuratorSupportedDirectory
}

extension CuratorKeyLocation: CuratorURLConvertible {
    public func asURL() throws -> URL {
        return fileURL(of: key, inDirectory: directory)
    }
}

private func fileURL(
    of key: String,
    inDirectory directory: CuratorSupportedDirectory,
    isDirectory: Bool = false
    ) -> URL {
    return directory.url.appendingPathComponent(key, isDirectory: isDirectory)
}

extension URL: CuratorURLConvertible {
    public func asURL() throws -> URL {
        return self
    }
}
