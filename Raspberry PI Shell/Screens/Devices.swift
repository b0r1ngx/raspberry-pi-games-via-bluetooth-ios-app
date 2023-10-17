import SwiftUI
import CoreBluetooth

struct Devices: View {
    @StateObject var viewModel: DevicesViewModel

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
            Button(action: {}) {
                Text("Scan"~)
            }
        }.onAppear {
            viewModel.start()
        }
    }
}

struct Device: View {
    var device: CBPeripheral
    var isConnectedTo: Bool = false
    var connect: () -> ()
    
    var body: some View {
        HStack {
            VStack {
                Text(device.name ?? "Unknown device"~)
                Text(device.identifier.uuidString)
                Text(device.rssi?.stringValue ?? "Unknown RSSI"~)
            }
            Spacer()
            if isConnectedTo {
                Image(systemName: "link")
            }
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .onTapGesture {
            connect()
        }
    }
}
