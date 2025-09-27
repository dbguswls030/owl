import SwiftUI

struct SettingView: View {
    var body: some View {
        VStack {
            Text("Owl")
                .foregroundStyle(.white)
                .font(.title)
        }
        .frame(maxWidth: .infinity, maxHeight: 100)
        .background(.black)
    }
}

#Preview {
    SettingView()
}
