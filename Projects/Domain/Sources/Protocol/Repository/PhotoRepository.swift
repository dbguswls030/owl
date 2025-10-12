import Foundation

public protocol PhotoRepository {
    func savePhoto(data: Data) async throws
}
