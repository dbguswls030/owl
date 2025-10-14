import SwiftUI

struct AspectRatioView: View {
    @Binding var selectedRatio: AspectRatioType

    var body: some View {
        VStack {
            HStack(spacing: 20) {
                ForEach(AspectRatioType.allCases, id: \.self) { ratioType in
                    Button(ratioType.rawValue) {
                        withAnimation {
                            selectedRatio = ratioType
                        }
                    }
                    .foregroundStyle(selectedRatio == ratioType ? .orange : .white)
                }
            }
        }
        .padding([.leading, .trailing], 20)
        .frame(maxWidth: .infinity)
        .background(.black)
    }
}

#Preview {
    AspectRatioView(selectedRatio: .constant(.original))
}
