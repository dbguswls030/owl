import Foundation

public final class DIContainerWrapper: ObservableObject {
    public let container: DIContainerProtocol

    public init(container: DIContainerProtocol) {
        self.container = container
    }
}
