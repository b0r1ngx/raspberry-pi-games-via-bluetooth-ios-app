import SwiftUI
import CoreBluetooth

struct Devices: View {
    @ObservedObject var viewModel: DevicesViewModel
    
    var body: some View {
        VStack {
            Text("Devices"~)
                .fontWeight(.bold)
            List(viewModel.devices, id: \.self) { device in
                Device(
                    device: device,
                    isConnectedTo: device == viewModel.connectedTo
                ) {
                    viewModel.connect(device: device)
                }
            }
            Spacer()
            Button(action: { viewModel.start() }) {
                Text("Scan"~)
                    .font(.system(size: 24))
            }
            .padding(.bottom, 40)
        }
        .alert(isPresented: $viewModel.isShowAlert) {
            Alert(
                title: Text(viewModel.alertTitle),
                message: Text(viewModel.alertMessage),
                dismissButton: .default(Text("OK"~)) {
                    viewModel.isShowAlert = false
                }
            )
        }
        // TODO: We can use this, and don't click on button
//        .onAppear {
//            viewModel.start()
//        }
    }
}

struct Device: View {
    var device: CBPeripheral
    var isConnectedTo: Bool = false
    var connect: () -> ()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(device.name ?? "Unknown device"~)
                    .fontWeight(.bold)
                Text("UUID: \(device.identifier.uuidString)")
                    .font(.system(size: 11))
                // Doesn't deprecated, just need to take from other place
                // P.S in Manager, you can see RSSI strength in console prints
                Text(device.rssi?.stringValue ?? "Unknown RSSI"~)
                    .font(.system(size: 11))
            }
            Spacer()
            if isConnectedTo {
                Image(systemName: "link")
                    .font(.system(size: 24))
            }
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        // User taps on one of the rows to pair with that device.
        .onTapGesture {
            connect()
        }
    }
}
