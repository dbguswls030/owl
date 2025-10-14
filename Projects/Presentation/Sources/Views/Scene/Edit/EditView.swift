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
                VStack(spacing: 0) {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(selectedRatio.ratio, contentMode: .fit)
                        .clipped()
                    Spacer()
                    AspectRatioView(selectedRatio: $selectedRatio)
                        .frame(height: geometry.size.height * 0.35)
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
        guard let data = selectedImage.pngData() else { return }
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
