extension Curator {
    public static func getData(of key: String, in directory: SupportedDirectory) throws -> Data {
        let location = KeyLocation(key: key, directory: directory)
        return try getData(from: location)
    }
}
