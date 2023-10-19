import SwiftUI

struct Splash: View {
    var body: some View {
        Image("lego")
            .renderingMode(.template)
            .foregroundColor(Color("Image"))
    }
}

#Preview {
    Splash()
}
