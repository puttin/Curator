public protocol CuratorLocation {
    func asURL() throws -> URL
}

extension CuratorLocation {
    typealias FileExistResult = (fileExist: Bool, isDirectory: Bool)
    func fileExist() throws -> FileExistResult {
        let url = try self.asURL()
        guard url.isFileURL else {
            throw CuratorError.locationIsNotFile
        }
        
        let path = url.path
        guard path.isEmpty == false else {
            throw CuratorError.invalidLocation(url: self)
        }
        
        var isDirectory: ObjCBool = false
        let fileExist = CuratorFileManager.fileExists(atPath: path, isDirectory: &isDirectory)
        return (fileExist, isDirectory.boolValue)
    }
}
