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
                    .frame(maxWidth: .infinity, maxHeight: 300)
                    .border(.gray, width: 1)
            } else {
                Text("No Image Selected")
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, maxHeight: 300)
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
            .padding()
        }
        .sheet(isPresented: $showPhotoPicker) {
            PHPhotoPickerView(selectedImage: $selectedImage)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
