import Domain
import Photos
import UIKit

public final class DefaultPhotoRepository: PhotoRepository {
    public init() {}
    
    public func savePhoto(data: Data) async throws {
        guard let photo = UIImage(data: data) else {
            throw PhotoError.conversionFailed
        }
        try await requestAuthorization()
        try await performChanges(image: photo)
    }

    private func requestAuthorization() async throws {
        let status = PHPhotoLibrary.authorizationStatus(for: .addOnly)

        if status == .notDetermined {
            await PHPhotoLibrary.requestAuthorization(for: .addOnly)
        }

        guard PHPhotoLibrary.authorizationStatus(for: .addOnly) == .authorized else {
            throw PhotoError.authorizationDenied
        }
    }

    private func performChanges(image: UIImage) async throws {
        do {
            try await PHPhotoLibrary.shared().performChanges {
                PHAssetChangeRequest.creationRequestForAsset(from: image)
            }
        } catch {
            throw PhotoError.saveFailed(error)
        }
    }
}
