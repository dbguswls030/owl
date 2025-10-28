import SwiftUI

struct EditView: View {
    @EnvironmentObject private var diContainer: DIContainerWrapper
    @State private var finishedEdit = false
    @State private var showExportView = false
    @State private var selectedRatio: AspectRatioType = .original
    @State private var convertedImage: UIImage?
    var selectedImage: UIImage

    var body: some View {
        GeometryReader { geometry in
            let finalRatio: CGFloat? = {
                if selectedRatio == .wallpaper {
                    return geometry.size.width / geometry.size.height
                } else {
                    return selectedRatio.ratio
                }
            }()
            VStack(spacing: 0) {
                ZStack {
                    Color.clear
                        .aspectRatio(finalRatio, contentMode: .fit)
                        .overlay {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .scaledToFill()
                        }
                        .clipped()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                AspectRatioView(selectedRatio: $selectedRatio)
                    .frame(height: 200)
            }
        }
        .background(.black)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("편집")
                    .foregroundStyle(.white)
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    finishedEdit = true
                } label: {
                    Image(systemName: "arrow.right")
                        .foregroundStyle(.white)
                }
            }
        }
        .onChange(of: finishedEdit) { _, newValue in
            if newValue {
                Task {
                    convertedImage = await convertPhoto()
                    showExportView = true
                }
            }
        }
        .sheet(item: $convertedImage) { image in
            ExportView(editedImage: image)
        }
    }

    private func convertPhoto() async -> UIImage? {
        let imageToSave: UIImage

        if selectedRatio == .original {
            imageToSave = self.selectedImage
        } else {
            let targetRatio = selectedRatio.ratio ??
            (selectedImage.size.width / selectedImage.size.height)
            guard let croppedImage = selectedImage.crop(to: targetRatio) else {
                print("오류 메시지")
                return nil
            }
            imageToSave = croppedImage
        }
        return imageToSave
    }
}

#Preview {
    NavigationStack {
        EditView(selectedImage: UIImage(resource: .temp))
    }
}
