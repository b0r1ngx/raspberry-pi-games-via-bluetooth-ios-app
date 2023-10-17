import SwiftUI
import CoreBluetooth
import Combine

class DevicesViewModel: ObservableObject {
    @Published var state: CBManagerState = .unknown
    @Published var peripherals: [CBPeripheral] = []
    
    private lazy var manager: BluetoothManager = .shared
    private lazy var cancellables: Set<AnyCancellable> = .init()
    
    deinit {
        cancellables.cancel()
    }
    
    func start() {
        manager.stateSubject
            .sink { [weak self] state in
                self?.state = state
            }
            .store(in: &cancellables)
        manager.peripheralSubject
            .filter { [weak self] in self?.peripherals.contains($0) == false }
            .sink { [weak self] in self?.peripherals.append($0) }
            .store(in: &cancellables)
        manager.start()
    }
}
