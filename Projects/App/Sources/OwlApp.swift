import Presentation
import SwiftUI

@main
struct OwlApp: App {
    @StateObject private var diContainerWrapper: DIContainerWrapper

    init() {
        let diContainer = DIContainer()
        self._diContainerWrapper = StateObject(wrappedValue: DIContainerWrapper(container: diContainer))
    }

    var body: some Scene {
        WindowGroup {
            PresentationFactory.makeRootView()
                .environmentObject(diContainerWrapper)
        }
    }
}
