public enum CuratorError: Error {
    case invalidURL(url: CuratorLocation)
    case urlIsNotFileURL
}
