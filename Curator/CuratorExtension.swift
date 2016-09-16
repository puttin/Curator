public protocol CuratorExtensionProtocol {
    associatedtype Base
    var base: Base { get }
}

public struct CuratorExtension<Base>: CuratorExtensionProtocol {
    public let base: Base
    init(_ base: Base) {
        self.base = base
    }
}
