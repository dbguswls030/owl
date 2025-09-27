import SwiftUI

struct PhotoPickerView: View {
    @Binding var showPhotoPicker: Bool
    var body: some View {
        VStack {
            Spacer()
            Button {
                showPhotoPicker = true
            } label: {
                 Image(systemName: "plus.circle.fill")
                    .resizable()
                    .foregroundStyle(.white)
                    .frame(width: 45, height: 45)
                    .clipShape(.circle)
            }
            .padding(.bottom)
        }
        .frame(maxWidth: .infinity, maxHeight: 150)
        .background(.black)
    }
}

#Preview {
    PhotoPickerView(showPhotoPicker: .constant(false))
}
