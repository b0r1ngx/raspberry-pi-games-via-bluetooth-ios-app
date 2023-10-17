import CoreBluetooth
import Combine
import Foundation

class BluetoothManager: NSObject {
    private var centralManager: CBCentralManager!
        
    var stateSubject: PassthroughSubject<CBManagerState, Never> = .init()
    var peripheralSubject: PassthroughSubject<CBPeripheral, Never> = .init()
    
    func start() {
        centralManager = .init(delegate: self, queue: .main)
    }
    
    func connect(_ peripheral: CBPeripheral) {
        centralManager.stopScan()
        peripheral.delegate = self
        centralManager.connect(peripheral)
    }
}

extension BluetoothManager: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            print("central.state is .unknown")
          case .resetting:
            print("central.state is .resetting")
          case .unsupported:
            print("central.state is .unsupported")
          case .unauthorized:
            print("central.state is .unauthorized")
          case .poweredOff:
            print("central.state is .poweredOff")
          case .poweredOn:
            print("central.state is .poweredOn")
        @unknown default:
            print("central.state is \(central.state)")
        }
    }
}
