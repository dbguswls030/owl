import SwiftUI

struct AspectRatioView: View {
    var body: some View {
        VStack {
            HStack {
                Text("1:1")
                    .foregroundStyle(.white)
                Spacer()
                Text("4:3")
                    .foregroundStyle(.white)
                Spacer()
                Text("16:9")
                    .foregroundStyle(.white)
            }
        }
        .padding([.leading, .trailing], 20)
        .frame(maxWidth: .infinity, maxHeight: 150)
        .background(.black)
    }
}

#Preview {
    AspectRatioView()
}
