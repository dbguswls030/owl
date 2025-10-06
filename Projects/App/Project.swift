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
                    "ITSAppUsesNonExemptEncryption": false,
                    "NSPhotoLibraryUsageDescription": "앨범에서 사진을 편집하기 위해 사진 라이브러리 접근이 필요합니다."
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
