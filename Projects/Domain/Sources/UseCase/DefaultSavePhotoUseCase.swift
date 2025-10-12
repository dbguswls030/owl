import Foundation

final public class DefaultSavePhotoUseCase: SavePhotoUseCase {
    private let repository: PhotoRepository

    public init(repository: PhotoRepository) {
        self.repository = repository
    }

    public func execute(data: Data) async throws {
        try await repository.savePhoto(data: data)
    }
}
