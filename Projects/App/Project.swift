import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "App",
    targets: [
        .makeTarget(
            name: "App",
            product: .app,
            dependencies: [
                .project(
                    target: "Presentation",
                    path: "../Presentation"
                ),
                .project(
                    target: "Data",
                    path: "../Data"
                ),
            ]
        )
    ]
)
