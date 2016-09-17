public struct Curator {
    
}

extension Curator {
    public static func save(
        _ keepable: CuratorKeepable,
        to location: CuratorLocation,
        options: Data.WritingOptions = [ .atomic],
        checkFileExist: Bool = true
        ) throws {
        let url = try location.asURL()
        
        if checkFileExist {
            let fileExistResult = try (url as CuratorLocation).fileExist()
            if fileExistResult.fileExist {
                if fileExistResult.isDirectory {
                    throw Error.locationIsDirectory(location)
                }
                else if options.contains( .withoutOverwriting) {
                    throw Error.locationFileExist(location)
                }
            }
            else {
                try (url as CuratorLocation).createDirectory()
            }
        }
        
        let data = try keepable.asData()
        
        try data.write(to: url, options: options)
    }
    
    public static func getData(
        from location: CuratorLocation,
        checkFileExist: Bool = true,
        options: Data.ReadingOptions = []
        ) throws -> Data {
        let url = try location.asURL()
        
        if checkFileExist {
            let fileExistResult = try url.fileExist()
            
            if !fileExistResult.fileExist {
                throw Error.locationFileNotExist(location)
            }
            
            if fileExistResult.isDirectory {
                throw Error.locationIsDirectory(location)
            }
        }
        
        let data = try Data(
            contentsOf: url,
            options: options
        )
        
        return data
    }
    
    private static func convertToFilePathURL(from location: CuratorLocation) throws -> URL {
        let locationURL = try location.asURL()
        let locationNSURL = locationURL as NSURL
        
        guard let resultURL = locationNSURL.filePathURL else {
            throw Error.unableToConvertToFileURL(from: location)
        }
        
        return resultURL
    }
}
