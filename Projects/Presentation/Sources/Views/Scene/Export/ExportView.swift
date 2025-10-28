import SwiftUI

struct ExportView: View {
    @EnvironmentObject private var diContainer: DIContainerWrapper
    @Environment(\.dismiss) private var dismiss
    @State private var showToast = false
    var editedImage: UIImage

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .foregroundStyle(.white)
                    }

                    Spacer()

                    Text("내보내기")
                        .font(.headline)
                        .padding(.trailing)

                    Spacer()
                }
                .frame(height: 44)
                .padding(.horizontal)

                VStack(spacing: 0) {
                    Color.clear
                        .aspectRatio(nil, contentMode: .fit)
                        .overlay {
                            Image(uiImage: editedImage)
                                .resizable()
                                .scaledToFit()
                        }
                        .clipped()
                        .frame(maxWidth: .infinity)
                }

                Spacer()

                Button {
                    Task {
                        await savePhoto()
                    }
                } label: {
                    Text("앨범에 저장")
                        .foregroundStyle(.white)
                }

                Spacer()

                HStack(spacing: 16) {
                    Button {

                    } label: {
                        Text("공유하기")
                    }
                }
            }

            if showToast {
                ToastView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showToast = false
                            }
                        }
                    }
            }
        }
        .preferredColorScheme(.dark)
    }

    private func savePhoto() async {
        guard let data = editedImage.pngData() else { return }
        let saveUseCase = diContainer.container.makeSavePhotoUseCase()
        do {
            try await saveUseCase.execute(data: data)
            withAnimation {
                showToast = true
            }
        } catch {
            print(error)
        }
    }
}

#Preview {
    ExportView(editedImage: UIImage(resource: .temp))
}
