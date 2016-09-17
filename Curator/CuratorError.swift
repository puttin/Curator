public enum CuratorError: Error {
    case invalidLocation(CuratorLocation)
    case unableToConvertToFileURL(from: CuratorLocation)
    case unableToObtainFileReferenceURL(from: CuratorLocation)
    case unableToCreateDirectory(for: CuratorLocation)
}
