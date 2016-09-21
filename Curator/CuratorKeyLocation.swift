extension Curator {
    public struct KeyLocation {
        public let key: String
        public let directory: SupportedDirectory
        
        public init(key: String, directory: SupportedDirectory) {
            self.key = key
            self.directory = directory
        }
    }
}

extension Curator.KeyLocation: CuratorLocation {
    public func asURL() throws -> URL {
        return fileURL(of: key, inDirectory: directory)
    }
}

private func fileURL(
    of key: String,
    inDirectory directory: Curator.SupportedDirectory,
    isDirectory: Bool = false
    ) -> URL {
    return directory.url.appendingPathComponent(key, isDirectory: isDirectory)
}

extension Curator.KeyLocation: Equatable {
    public static func ==(lhs: Curator.KeyLocation, rhs: Curator.KeyLocation) -> Bool {
        return lhs.directory == rhs.directory && lhs.key == rhs.key
    }
}
