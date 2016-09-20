public protocol CuratorLocation {
    func asURL() throws -> URL
}

extension CuratorLocation {
    func fileReferenceURL() throws -> URL {
        let url = try self.standardizedFileURL() as NSURL
        
        guard let fileReferenceURL = url.fileReferenceURL() else {
            throw Curator.Error.unableToObtainFileReferenceURL(from: self)
        }
        
        return fileReferenceURL as URL
    }
    
    func standardizedFileURL() throws -> URL {
        let location = self
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
