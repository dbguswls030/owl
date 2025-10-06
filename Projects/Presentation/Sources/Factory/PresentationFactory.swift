import SwiftUI

public struct PresentationFactory: PresentationFactoryProtocol {
    public static func makeRootView() -> AnyView {
        AnyView(MainView())
    }
}
