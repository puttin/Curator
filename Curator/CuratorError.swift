extension Curator {
    public enum Error: Swift.Error {
        case invalidLocation(CuratorLocation)
        case unableToConvertToFileURL(from: CuratorLocation)
        case unableToConvertToFilePathURL(from: CuratorLocation)
        case unableToObtainFileReferenceURL(from: CuratorLocation)
        case locationIsFile(CuratorLocation)
        case locationIsDirectory(CuratorLocation)
        case locationFileExist(CuratorLocation)
        case locationFileNotExist(CuratorLocation)
    }
}
