import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Domain",
    targets: [
        Project.makeTarget(
            name: "Domain",
            product: .framework,
            dependencies: []
        )
    ]
)
