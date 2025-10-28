import SwiftUI

struct ExportView: View {
    @EnvironmentObject private var diContainer: DIContainerWrapper
    @Environment(\.dismiss) var dismiss
    @State private var showToast = false
    var editedImage: UIImage

    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                HStack(alignment: .top) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                           .resizable()
//                           .foregroundStyle(.gray)
                           .frame(width: 32, height: 32)
                           .clipShape(.circle)
                    }
                    .padding()

                    Spacer()
                }

                Spacer()
                //                Color.clear
                //                .aspectRatio(nil, contentMode: .fit)
                //                    .overlay {
                Image(uiImage: editedImage)
                    .resizable()
                    .scaledToFill()
                    .aspectRatio(nil, contentMode: .fit) // 추가
                //                    }
                //                    .clipped()
                Button {
                    Task {
                        await savePhoto()
                    }
                } label: {
                    Text("앨범에 저장")
                }

                HStack(spacing: 16) {
                    Button {

                    } label: {
                        Text("공유하기")
                    }
                }
                .frame(height: 200)
            }
        }
        .preferredColorScheme(.dark)

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
