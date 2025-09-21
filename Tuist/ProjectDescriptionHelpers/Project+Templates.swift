import ProjectDescription

public extension Project {
    static func makeTarget(
        name: String,
        product: Product,
        dependencies: [TargetDependency] = []
    ) -> Target {
        let destinations: Destinations = .iOS
        let baseBundleId = "ryuhyeonjin.owl"

        return .target(
            name: name,
            destinations: destinations,
            product: product,
            bundleId: "\(baseBundleId).\(name)",
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: product == .app ? ["Resources/**"] : [],
            dependencies: dependencies
        )
    }
}