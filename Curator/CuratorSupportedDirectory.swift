extension Curator {
    public enum SupportedDirectory {
        case documents
        case caches
        case applicationSupport
        case tmp
    }
}

public extension Curator.SupportedDirectory {
    var url: URL {
        switch self {
        case .documents:
            return documentsDirectory
        case .caches:
            return cacheDirectory
        case .applicationSupport:
            return applicationSupportDirectory
        case .tmp:
            return tmpDirectory
        }
    }
}

private func getURLInUserDomain(
    for directory: FileManager.SearchPathDirectory
    ) -> URL? {
    return CuratorFileManager.urls(for: directory, in: .userDomainMask).first
}

private let documentsDirectory: URL = {
    return getURLInUserDomain(for: .documentDirectory)!
}()

private let cacheDirectory: URL = {
    return getURLInUserDomain(for: .cachesDirectory)!
}()

private let applicationSupportDirectory: URL = {
    return getURLInUserDomain(for: .applicationSupportDirectory)!
}()

private let tmpDirectory: URL = {
    return URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
}()
