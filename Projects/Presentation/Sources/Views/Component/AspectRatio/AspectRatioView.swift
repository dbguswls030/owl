import SwiftUI

struct AspectRatioView: View {
    var body: some View {
        VStack {
            Spacer()
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
            Spacer()
        }
        .padding([.leading, .trailing], 20)
        .frame(maxWidth: .infinity)
        .background(.black)
    }
}

#Preview {
    AspectRatioView()
}
