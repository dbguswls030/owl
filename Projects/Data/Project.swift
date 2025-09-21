import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Data",
    targets: [
        Project.makeTarget(
            name: "Data",
            product: .framework,
            dependencies: [
                .project(
                    target: "Domain",
                    path: "../Domain"
                ),
            ]
        )
    ]
)
