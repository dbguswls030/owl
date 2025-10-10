import Foundation

public protocol SavePhotoUseCase {
    func execute(data: Data) async throws
}
