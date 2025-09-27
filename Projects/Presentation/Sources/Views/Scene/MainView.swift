import SwiftUI

struct MainView: View {
    @State private var showPhotoPicker = false
    @State private var selectedImage: UIImage?
    private var isEditing: Bool {
        selectedImage != nil
    }
    @State private var next = false

    init() {}

    var body: some View {
        VStack(spacing: 0) {
            SettingView(
                isEditing: isEditing,
                next: $next
            )
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()
            } else {
                Text("No Image Selected")
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            PhotoPickerView(showPhotoPicker: $showPhotoPicker)
        }
        .sheet(isPresented: $showPhotoPicker) {
            PHPhotoPickerView(selectedImage: $selectedImage)
        }
    }
}

#Preview {
    MainView()
}
