import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Domain",
    targets: [
        .makeTarget(
            name: "Domain",
            product: .framework,
            dependencies: []
        )
    ]
)
