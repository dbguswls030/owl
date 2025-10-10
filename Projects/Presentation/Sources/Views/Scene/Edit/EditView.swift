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

//            VStack {
//
//            }
//            .frame(maxWidth: .infinity, maxHeight: 150)
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
                diContainer.container.makeSavePhotoUseCase().execute()
            }
        }
    }
}

#Preview {
    NavigationStack {
        EditView(selectedImage: UIImage(resource: .temp))
    }
}
