public struct CuratorKeyLocation {
    let key: String
    let directory: CuratorSupportedDirectory
}

extension CuratorKeyLocation: CuratorLocation {
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
