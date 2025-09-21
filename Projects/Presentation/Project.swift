import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Presentation",
    targets: [
        Project.makeTarget(
            name: "Presentation",
            product: .framework,
            dependencies: [
                .project(
                    target: "Domain",
                    path: "../Domain"
                )
            ]
        )
    ]
)
