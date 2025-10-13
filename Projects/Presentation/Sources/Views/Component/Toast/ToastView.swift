import SwiftUI

struct ToastView: View {
    var body: some View {
        VStack(spacing: 15) {
            Image(systemName: "checkmark")
                .font(.largeTitle)
                .foregroundStyle(.white)
            Text("저장 성공")
                .font(.body)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 30)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color.black.opacity(0.7))
        )
        .transition(.opacity.combined(with: .move(edge: .bottom)))
    }
}

#Preview {
    ToastView()
}
