import SwiftUI

struct MainView: View {
    @State private var showPhotoPicker = false
    @State private var selectedImage: UIImage?

    init() {}

    var body: some View {
        VStack {
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            } else {
                Text("No Image Selected")
                    .foregroundStyle(.gray)
                    .frame(width: 300, height: 300)
                    .border(.gray, width: 1)
            }

            Button("open PHPicker") {
                showPhotoPicker = true
            }
            .padding()
            .background(.purple)
            .foregroundStyle(.white)
            .clipShape(.circle)
        }
        .sheet(isPresented: $showPhotoPicker) {
            PHPhotoPickerView(selectedImage: $selectedImage)
        }
    }
}
