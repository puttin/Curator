extension Data {
    public var crt: CuratorExtension<Data> {
        return CuratorExtension(self)
    }
}

extension CuratorExtensionProtocol where Base == Data {
    
}
