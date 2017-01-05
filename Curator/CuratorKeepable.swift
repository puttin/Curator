import Foundation

public protocol CuratorKeepable {
    func asData() throws -> Data
}
