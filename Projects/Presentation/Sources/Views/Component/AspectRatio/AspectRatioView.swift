import SwiftUI

struct AspectRatioView: View {
    @Binding var selectedRatio: AspectRatioType

    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    ForEach(AspectRatioType.allCases, id: \.self) { ratioType in
                        Button {
                            withAnimation {
                                selectedRatio = ratioType
                            }
                        } label: {
                            Text(ratioType.rawValue)
                                .foregroundStyle(selectedRatio == ratioType ? .orange : .white)
                                .font(.subheadline)
                        }
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .background(.black)
    }
}

#Preview {
    AspectRatioView(selectedRatio: .constant(.original))
}
