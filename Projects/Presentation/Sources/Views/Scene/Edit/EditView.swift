import SwiftUI

struct EditView: View {
    @EnvironmentObject private var diContainer: DIContainerWrapper
    @State private var save = false
    @State private var successedSave = false
    @State private var selectedRatio: AspectRatioType = .original
    var selectedImage: UIImage

    var body: some View {
        ZStack {
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
                        .frame(height: 150)
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
                        save = true
                    } label: {
                        Image(systemName: "tray.and.arrow.down")
                            .foregroundStyle(.white)
                    }
                }
            }
            .onChange(of: save) { _, newValue in
                if newValue {
                    Task {
                        await savePhoto()
                    }
                }
            }
            if successedSave {
                ToastView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                successedSave = false
                            }
                        }
                    }
            }
        }
    }

    private func savePhoto() async {
        let imageToSave: UIImage

        if selectedRatio == .original {
            imageToSave = self.selectedImage
        } else {
            let targetRatio = selectedRatio.ratio ??
            (selectedImage.size.width / selectedImage.size.height)
            guard let croppedImage = selectedImage.crop(to: targetRatio) else {
                print("오류 메시지")
                return
            }
            imageToSave = croppedImage
        }

        guard let data = imageToSave.pngData() else { return }
        let saveUseCase = diContainer.container.makeSavePhotoUseCase()
        do {
            try await saveUseCase.execute(data: data)
            withAnimation {
                successedSave = true
            }
        } catch {
            print(error)
        }
    }
}

#Preview {
    NavigationStack {
        EditView(selectedImage: UIImage(resource: .temp))
    }
}
