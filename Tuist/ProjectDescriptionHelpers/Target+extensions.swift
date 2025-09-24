import Foundation
import ProjectDescription

fileprivate let commonScripts: [TargetScript] = [
    .pre(
        script: """
            # mise에서 설치된 swiftlint 사용하도록 설정
            if [ -d "$HOME/.local/share/mise/shims" ]; then
                export PATH="$HOME/.local/share/mise/shims:$PATH"
            else
                echo "mise shims directory not found"
            fi
            
            # 현재 PATH 출력
            echo "Current PATH: $PATH"
            
            # swiftlint 경로 확인
            SWIFTLINT_PATH=$(which swiftlint)
            echo "❗️SwiftLint Path: $SWIFTLINT_PATH"
            SWIFTLINT_CONFIG_PATH="${SRCROOT%/*/*}/.swiftlint.yml"
            echo "❗️SRCROOT Path: ${SWIFTLINT_CONFIG_PATH}"
            
            # SwiftLint 실행
            if [ -n "$SWIFTLINT_PATH" ]; then
                swiftlint --config "$SWIFTLINT_CONFIG_PATH"
            else
                echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
            fi
            
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
