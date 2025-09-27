import SwiftUI

struct SettingView: View {
    var isEditing: Bool
    @Binding var next: Bool

    var body: some View {
        VStack {
            HStack {
                Spacer()
                if isEditing {
                    Button {
                        next = true
                    } label: {
                        Image(systemName: "arrow.right")
                            .resizable()
                            .foregroundStyle(.white)
                            .frame(width: 18, height: 18)
                    }
                    .padding()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 100)
        .background(.black)
    }
}

#Preview {
    SettingView(
        isEditing: true,
        next: .constant(false)
    )
}
