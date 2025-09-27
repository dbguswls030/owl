import SwiftUI

struct MainView: View {
    @State private var showPhotoPicker = false
    @State private var selectedImage: UIImage?

    init() {}

    var body: some View {
        VStack {
            if let image = selectedImage {
                // TODO: 화면 크게
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

            Button {
                showPhotoPicker = true
            } label: {
                 Image(systemName: "plus.circle.fill")
                    .resizable()
                    .foregroundStyle(.black)
                    .frame(width: 50, height: 50)
                    .clipShape(.circle)
            }
        }
        .sheet(isPresented: $showPhotoPicker) {
            PHPhotoPickerView(selectedImage: $selectedImage)
        }
    }
}
