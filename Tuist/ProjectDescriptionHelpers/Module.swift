import Foundation

public enum Module: String, CaseIterable {
    case App
    case Data
    case Domain
    case Presentation

    public var name: String {
        return self.rawValue
    }
}
