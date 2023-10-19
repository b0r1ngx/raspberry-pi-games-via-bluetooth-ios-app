import SwiftUI

struct BottomTabBar: View {
    @ObservedObject var viewModel: DevicesViewModel
    
    var body: some View {
            TabView {
                Games()
                    .tabItem {
                        Image(systemName: "gamecontroller")
                        Text("Games"~)
                    }
                Devices(viewModel: viewModel)
                    .tabItem {
                        // Solve with images, because additional drawings
                        // or elements on tabItem is not reserved by SDK
                        Image(
                            viewModel.connectedTo != nil ? "bluetooth_green" : "bluetooth_red"
                        )
                        Text("Devices"~)
                    }
                Translation(
                    translation: viewModel.translation
                ).tabItem {
                    Image("translate")
                        .renderingMode(.template)
                    Text("Translation"~)
                }
            }
    }
}

#Preview {
    BottomTabBar(
        viewModel: DevicesViewModel.shared
    )
}
