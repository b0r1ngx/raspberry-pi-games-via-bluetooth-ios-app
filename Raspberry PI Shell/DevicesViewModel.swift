import SwiftUI
import CoreBluetooth
import Combine

class DevicesViewModel: ObservableObject {
    @Published var state: CBManagerState = .unknown
    @Published var devices: [CBPeripheral] = []
    @Published var connectedTo: CBPeripheral?
    
    private lazy var manager: BluetoothManager = .shared
    private lazy var cancellables: Set<AnyCancellable> = .init()
    
    let translation = decode(file: "translations.json")
    
    deinit {
        cancellables.removeAll()
    }
    
    func start() {
        manager.stateSubject
            .sink { [weak self] state in
                self?.state = state
                if state == .poweredOn {
                    self?.manager.scan()
                }
            }
            .store(in: &cancellables)
        
        manager.peripheralSubject
            .filter { [weak self] in
                self?.devices.contains($0) == false
            }
            .sink { [weak self] in
                print($0)
                self?.devices.append($0)
            }
            .store(in: &cancellables)
        
        manager.start()
    }
    
    func connect(device: CBPeripheral) {
        manager.connect(device)
        if device.state == .connected {
            connectedTo = device
        }
    }
}
