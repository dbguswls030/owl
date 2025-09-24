import Foundation
import ProjectDescription

fileprivate let commonScripts: [TargetScript] = [
  .pre(
    script: """
    ROOT_DIR=\(ProcessInfo.processInfo.environment["TUIST_ROOT_DIR"] ?? "")
    
    ${ROOT_DIR}/swiftlint --config ${ROOT_DIR}/.swiftlint.yml
    
    """,
    name: "SwiftLint",
    basedOnDependencyAnalysis: false
  )
]


public extension Target {
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
            deploymentTargets: .iOS("17.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: product == .app ? ["Resources/**"] : [],
            scripts: commonScripts,
            dependencies: dependencies
        )
    }
}
