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
        NavigationStack {
            VStack(spacing: 0) {
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
            .background(.black)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("이미지 선택")
                        .foregroundStyle(.white)
                }
                if isEditing {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            selectedImage = nil
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            next = true
                        } label: {
                            Image(systemName: "arrow.right")
                                .foregroundStyle(.white)
                        }
                        .disabled(!isEditing)
                    }
                }
            }
        }
    }
}

#Preview {
    MainView()
}
