import CoreGraphics
import Foundation

enum AspectRatioType: String, CaseIterable {
    case original = "원본"
    case square = "정방형"
    case custom916 = "9:16"
    case custom45 = "4:5"
    case custom57 = "5:7"
    case custom34 = "3:4"
    case custom35 = "3:5"
    case custom23 = "2:3"

    var ratio: CGFloat? {
        switch self {
        case .original:
            return nil
        case .square:
            return 1.0
        case .custom916:
            return 9.0 / 16.0
        case .custom45:
            return 4.0 / 5.0
        case .custom57:
            return 5.0 / 7.0
        case .custom34:
            return 3.0 / 4.0
        case .custom35:
            return 3.0 / 5.0
        case .custom23:
            return 2.0 / 3.0
        }
    }
}
