//
//  BLEBPeripheralManager.swift
//  BazBluetooth
//
//  Created by Usuario  on 19/08/24.
//
import UIKit
import CoreBluetooth


// MARK: - Class
class BLEBPeripheralManager: NSObject {

    //MARK: - Shared
    static let shared = BLEBPeripheralManager()
    //MARK: - Delegate
    weak var delegate : BLEBPeripheralDelegate?
    //MARK: - Properties
    private var peripheralManager: CBPeripheralManager!
    var transferCharacteristic: CBCharacteristic?
    var peripheralCharacteristic: CBMutableCharacteristic?
    var connectedCentral: CBCentral?

    
    //MARK: - Life Cycle
    private override init() {()}
    
    //MARK: - Methods
    func initPeripheralManager(){
        peripheralManager = CBPeripheralManager(delegate: self, queue: DispatchQueue.main)
    }
    
    func writeRespone(data: Data){
        guard let peripheralCharacteristic = peripheralCharacteristic else {return}
        guard let connectedCentral = connectedCentral else {return}
        peripheralManager?.updateValue(data, for: peripheralCharacteristic, onSubscribedCentrals: [connectedCentral])
        
    }
    
    func stopstopAdvertising(){
        peripheralManager.stopAdvertising()
    }
    
    func cancelConnection() {
        peripheralManager.stopAdvertising()
        peripheralManager.removeAllServices()
    }
}

// MARK: - CB Peripheral Manager Delegate
extension BLEBPeripheralManager: CBPeripheralManagerDelegate {
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        switch peripheral.state {
        case .poweredOn:
            print("El estado periférico es encendido")
            createPeripheralService()
        case .poweredOff:
            delegate?.bluetoothOff(true)
        default:
            print("Bluetooth needs to be powered on!")
        }
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didAdd service: CBService, error: Error?) {
        guard service.uuid == BLEConstants.shared.serviceUUID else {
            return
        }
        print("BLE: peripherical service created")
        startAdvertising()
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        for request in requests {
            if let value = request.value {
                guard let message = String(data: value, encoding: String.Encoding.utf8) else {return}
                print("Mensaje recibido:  \(String(describing: message))")
                delegate?.messageResponse(message)
            }
            peripheralManager.respond(to: request, withResult: .success)
        }
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didSubscribeTo characteristic: CBCharacteristic) {
            print(characteristic.uuid)
            connectedCentral = central
            delegate?.onConection(true)
            stopstopAdvertising()
        
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didUnsubscribeFrom characteristic: CBCharacteristic) {
        print("Se desconecto")
        delegate?.onConection(false)
    }
}

//MARK: - Private functions
extension BLEBPeripheralManager {
    private func startAdvertising() {
        peripheralManager.startAdvertising([CBAdvertisementDataServiceUUIDsKey:[BLEConstants.shared.serviceUUID],CBAdvertisementDataLocalNameKey: UIDevice.current.name])
        print("BLE: start adversting")
    }
    
    private func createPeripheralService() {
        peripheralCharacteristic = CBMutableCharacteristic(type: BLEConstants.shared.rxUUID, properties: BLEConstants.shared.rxProperties, value: nil, permissions: BLEConstants.shared.rxPermissions)
        let service = CBMutableService(type: BLEConstants.shared.serviceUUID, primary: true)
        service.characteristics = [self.peripheralCharacteristic!]
            peripheralManager?.add(service)
    }
}
