public struct Curator {
    
}

extension Curator {
    static func save(
        _ keepable: CuratorKeepable,
        to location: CuratorLocation,
        options: Data.WritingOptions = [ .atomic]
        ) throws {
        let url = try location.asURL()
        
        let fileExistResult = try url.fileExist()
        if fileExistResult.fileExist {
            if fileExistResult.isDirectory {
                throw Error.locationIsDirectory(location)
            }
            else if options.contains( .withoutOverwriting) {
                throw Error.locationFileExist(location)
            }
        }
        
        try location.createDirectory()
        
        let data = try keepable.asData()
        
        try data.write(to: url, options: options)
    }
    
    static func getData(
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
}
