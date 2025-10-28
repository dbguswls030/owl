import UIKit

extension UIImage {
    func crop(to aspectRatio: CGFloat) -> UIImage? {
        guard let cgImage = self.cgImage else { return nil }

        let originalWidth = CGFloat(cgImage.width)
        let originalHeight = CGFloat(cgImage.height)
        let originalRatio = originalWidth / originalHeight

        var newWidth = originalWidth
        var newHeight = originalHeight

        if originalRatio > aspectRatio {
            newWidth = originalHeight * aspectRatio
        } else {
            newHeight = originalWidth / aspectRatio
        }

        let newX = (originalWidth - newWidth) / 2.0
        let newY = (originalHeight - newHeight) / 2.0

        let cropRect = CGRect(
            x: newX,
            y: newY,
            width: newWidth,
            height: newHeight
        )

        guard let croppedCGImage = cgImage.cropping(to: cropRect) else { return nil }

        return UIImage(
            cgImage: croppedCGImage,
            scale: self.scale,
            orientation: self.imageOrientation
        )
    }
}

extension UIImage: @retroactive Identifiable {
    public var id: UUID {
        UUID()
    }
}
