extension CuratorKeepable {
    public var crt: CuratorExtension<CuratorKeepable> {
        return CuratorExtension(self)
    }
}

extension CuratorExtensionProtocol where Base == CuratorKeepable {
    public func save(to location: CuratorLocation) throws {
        try Curator.save(base, to: location)
    }
    
    public func save(to key: String, in directory: Curator.SupportedDirectory) throws {
        let location = Curator.KeyLocation(key: key, directory: directory)
        try save(to: location)
    }
}
