import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "App",
    targets: [
        .makeTarget(
            name: "App",
            product: .app,
            infoPlist: .extendingDefault(
                with: [
                    "CFBundleDisplayName": "Owl",
                    "LSApplicationCategoryType": "public.app-category.photo-video",
                    "CFBundleShortVersionString": "1.0.0",
                    "CFBundleVersion" : "1",
                    "UISupportedInterfaceOrientations": [
                        "UIInterfaceOrientationPortrait"
                    ],
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
//                    "CFBundleIconName" : "AppIcon",
                    "ITSAppUsesNonExemptEncryption": false
                ]
            ),
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
