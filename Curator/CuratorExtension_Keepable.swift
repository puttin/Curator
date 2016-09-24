extension CuratorKeepable {
    public var crt: CuratorExtension<CuratorKeepable> {
        return CuratorExtension(self)
    }
}

extension CuratorExtensionProtocol where Base == CuratorKeepable {
    public func save(to location: CuratorLocation) throws {
        try Curator.save(base, to: location)
    }
}
