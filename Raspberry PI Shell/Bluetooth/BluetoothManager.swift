import CoreBluetooth
import Combine
import Foundation

class BluetoothManager: NSObject, CBPeripheralDelegate {
    static let shared = BluetoothManager()
    
    private var centralManager: CBCentralManager!
        
    var stateSubject: PassthroughSubject<CBManagerState, Never> = .init()
    var peripheralSubject: PassthroughSubject<CBPeripheral, Never> = .init()
    
    // If u need scan for devices with specific services, we can use this variable
    // for example this may be needed if you want only scan for Raspberry PI devices,
    // then u need to know, your UUID of device, then, change nil with: [CBUUID(string: "0x0000")]
    // we can find UUID for some devices in this specification: https://btprodspecificationrefs.blob.core.windows.net/assigned-numbers/Assigned%20Number%20Types/Assigned_Numbers.pdf
    
    // for example, from link, Glucose service have UUID 0x1808, we make it like that:
    // let serviceCBUUID: [CBUUID]? = [CBUUID(string: "0x1808")]
    let serviceCBUUID: [CBUUID]? = nil
    
    func start() {
        centralManager = .init(delegate: self, queue: nil) // queue: .main
    }
    
    func scan() {
        centralManager.scanForPeripherals(withServices: serviceCBUUID)
    }
    
    func connect(_ peripheral: CBPeripheral) {
        centralManager.stopScan()
        peripheral.delegate = self
        centralManager.connect(peripheral)
    }
}

extension BluetoothManager: CBCentralManagerDelegate {
    // Shows bluetooth status of device where we searching from (phone)
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
        stateSubject.send(central.state)
    }
        
    func centralManager(
        _ central: CBCentralManager,
        didDiscover peripheral: CBPeripheral,
        advertisementData: [String : Any],
        rssi RSSI: NSNumber
    ) {
        peripheralSubject.send(peripheral)
        print(peripheral)
        print("RSSI: \(RSSI)")
    }
    
    func centralManager(
        _ central: CBCentralManager,
        didConnect peripheral: CBPeripheral
    ) {
        if peripheral.state == .connected {
            let name = peripheral.name ?? "Unknown device"
            DevicesViewModel.shared.connectedTo = peripheral
            print("Connected to \(name) (id: \(peripheral.identifier))")
        } else {
            DevicesViewModel.shared.isShowAlert = true
            DevicesViewModel.shared.alertTitle = "Not connected"
            DevicesViewModel.shared.alertMessage = "TODO: provide error here"
        }
    }
}
