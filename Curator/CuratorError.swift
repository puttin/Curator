public enum CuratorError: Error {
    case invalidLocation(url: CuratorLocation)
    case locationIsNotFile
    case cannotObtainFileReferenceURL(from: CuratorLocation)
}
