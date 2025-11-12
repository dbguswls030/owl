import SwiftUI

struct EditView: View {
    @EnvironmentObject private var diContainer: DIContainerWrapper
    @State private var finishedEdit = false
    @State private var selectedRatio: AspectRatioType = .original
    @State private var convertedImage: UIImage?
    var selectedImage: UIImage

    var body: some View {
        GeometryReader { geometry in
            let finalRatio:
            CGFloat? = {
                if selectedRatio == .wallpaper {
                    return geometry.size.width / geometry.size.height
                } else {
                    return selectedRatio.ratio
                }
            }()

            VStack(spacing: 0) {
                Spacer()
                ZStack {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFill()
                }
                .background(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .aspectRatio(finalRatio, contentMode: .fit)
                .clipped()
                .frame(height: max(0, geometry.size.height - 200))
                .clipped()

                AspectRatioView(selectedRatio: $selectedRatio)
                    .frame(height: 200)
            }
        }
        .background(.black)
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
                }
            }
        }
        .fullScreenCover(item: $convertedImage) { image in
            ExportView(editedImage: image)
        }
    }

    private func convertPhoto() async -> UIImage? {
        let imageToSave: UIImage

        if selectedRatio == .original {
            imageToSave = self.selectedImage
        } else {
            let targetRatio: CGFloat

            if selectedRatio == .wallpaper {
                let screenSize = UIScreen.main.bounds.size
                targetRatio = screenSize.width / screenSize.height
            } else {
                guard let ratio = selectedRatio.ratio else {
                    print("오류 메시지: 비율을 찾을 수 없습니다.")
                    return nil
                }
                targetRatio = ratio
            }
            guard let fittedImage = selectedImage.crop(to: targetRatio, backgroundColor: .white) else {
                print("오류 메시지: 캔버스에 맞추기 실패")
                return nil
            }
            imageToSave = fittedImage
        }
        return imageToSave
    }
}

#Preview {
    NavigationStack {
        EditView(selectedImage: UIImage(resource: .temp))
    }
}
