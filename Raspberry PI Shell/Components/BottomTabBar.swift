import SwiftUI

struct BottomTabBar: View {
    @StateObject private var viewModel = DevicesViewModel()
    
    var body: some View {
        let _ = print("Hello")
        TabView {
            Games()
                .tabItem {
                    Image(systemName: "gamecontroller")
                    Text("Games"~)
                }
            Devices(viewModel: viewModel)
                .tabItem {
                    Image("bluetooth")
                    Text("Devices"~)
                }
            Translation(
                translation: viewModel.translation
            ).tabItem {
                Image("translate")
                Text("Translation"~)
            }
        }.accentColor(Green)
    }
}

#Preview {
    BottomTabBar()
}
