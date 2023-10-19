import SwiftUI
import CoreBluetooth
import Combine

class DevicesViewModel: ObservableObject {
    @Published var state: CBManagerState = .unknown
    @Published var devices: [CBPeripheral] = []
    @Published var connectedTo: CBPeripheral?
    @Published var isShowAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    static let shared = DevicesViewModel()
    
    // without Alert it possible to make it private
    var manager: BluetoothManager = .shared
    private lazy var cancellables: Set<AnyCancellable> = .init()
    
    let translation = decode(file: "translations.json")
    
    deinit {
        cancellables.removeAll()
    }
    
    func start() {
        // User presses the “Scan” button and the tab updates to show a list of devices.
        devices.removeAll()
        
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
                self?.devices.append($0)
            }
            .store(in: &cancellables)
        
        manager.start()
    }
    
    func connect(device: CBPeripheral) {
        print("Trying connect to \(device)")
        manager.connect(device)
    }
}
