import Presentation
import SwiftUI

@main
struct OwlApp: App {
    var body: some Scene {
        WindowGroup {
            PresentationFactory.makeRootView()
        }
    }
}
