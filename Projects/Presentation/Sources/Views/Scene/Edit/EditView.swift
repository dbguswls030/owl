import SwiftUI

struct EditView: View {
    @EnvironmentObject private var diContainer: DIContainerWrapper
    @State private var save = false
    var selectedImage: UIImage

    var body: some View {
        VStack(spacing: 0) {
            Image(uiImage: selectedImage)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()

            AspectRatioView()
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
    }

    private func savePhoto() async {
        guard let data = selectedImage.pngData() else { return }
        let saveUseCase = diContainer.container.makeSavePhotoUseCase()
        do {
            try await saveUseCase.execute(data: data)
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
