import SwiftUI

@main
struct Raspberry_PI_ShellApp: App {
    @StateObject private var viewModel = DevicesViewModel.shared
    @State var isShowingSplash = true
    
    var body: some Scene {
        WindowGroup {
            if isShowingSplash {
                Splash().onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation {
                            isShowingSplash = false
                        }
                    }
                }
            } else {
                BottomTabBar(viewModel: viewModel)
            }
        }
    }
}
