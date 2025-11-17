import UIKit

extension UIImage {
    func crop(to aspectRatio: CGFloat, backgroundColor: UIColor) -> UIImage? {
        guard let cgImage = self.cgImage else { return nil }

        let originalWidth = CGFloat(cgImage.width)
        let originalHeight = CGFloat(cgImage.height)
        let originalRatio = originalWidth / originalHeight

        let canvasWidth = originalWidth
        let canvasHeight = canvasWidth / aspectRatio
        let canvasSize = CGSize(width: canvasWidth, height: canvasHeight)

        let renderer = UIGraphicsImageRenderer(size: canvasSize)

        let newImage = renderer.image { context in
            backgroundColor.setFill()
            context.fill(CGRect(origin: .zero, size: canvasSize))

            var drawRect: CGRect

            if originalRatio > aspectRatio {
                let scaledHeight = canvasHeight
                let scaledWidth = scaledHeight * originalRatio

                let newX = (canvasWidth - scaledWidth) / 2.0
                drawRect = CGRect(x: newX, y: 0, width: scaledWidth, height: scaledHeight)
            } else {
                let scaledWidth = canvasWidth
                let scaledHeight = scaledWidth / originalRatio

                let newY = (canvasHeight - scaledHeight) / 2.0
                drawRect = CGRect(x: 0, y: newY, width: scaledWidth, height: scaledHeight)
            }
            self.draw(in: drawRect)
        }
        return newImage
    }
}

extension UIImage: @retroactive Identifiable {
    public var id: UUID {
        UUID()
    }
}
