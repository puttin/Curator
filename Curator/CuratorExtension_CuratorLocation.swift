extension CuratorLocation {
    var crt: CuratorExtension<Self> {
        return CuratorExtension(self)
    }
}

extension CuratorExtension where Base: CuratorLocation {
    func standardizedFileURL() throws -> URL {
        let location = base
        let url = try location.asURL()
        guard url.isFileURL else {
            throw Curator.Error.unableToConvertToFileURL(from: location)
        }
        
        let standardizedURL = url.standardized
        let path = standardizedURL.path
        guard !path.isEmpty else {
            throw Curator.Error.invalidLocation(location)
        }
        
        return standardizedURL
    }
}
