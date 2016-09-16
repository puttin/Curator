import Foundation

let CuratorFileManager = FileManager()

extension URL: CuratorLocation {
    public func asURL() throws -> URL {
        return self
    }
}
