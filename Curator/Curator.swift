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
}
