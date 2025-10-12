import Data
import Domain
import Presentation

final public class DIContainer: DIContainerProtocol {
    public func makeSavePhotoUseCase() -> SavePhotoUseCase {
        let repository = DefaultPhotoRepository()
        return DefaultSavePhotoUseCase(repository: repository)
    }
}
