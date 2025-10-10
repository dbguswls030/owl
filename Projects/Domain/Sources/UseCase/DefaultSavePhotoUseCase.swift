final public class DefaultSavePhotoUseCase: SavePhotoUseCase {
    private let repository: PhotoRepository

    public init(repository: PhotoRepository) {
        self.repository = repository
    }

    public func execute() {
        print("\(Self.self) execute")
    }
}
