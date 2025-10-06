import SwiftUI

public protocol PresentationFactoryProtocol {
    static func makeRootView() -> AnyView
}
