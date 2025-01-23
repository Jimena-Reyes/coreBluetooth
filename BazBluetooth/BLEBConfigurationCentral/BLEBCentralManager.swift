//
//  BLEBCentral.swift
//  BazBluetooth
//
//  Created by Usuario  on 19/08/24.
//
import Foundation
import CoreBluetooth

protocol BLEBSesionDelegate: AnyObject {
    func messageR(_ message:String)
    func bluetoothOff(_ bluetoothOff: Bool)

    
}

// MARK: - Class
class BLEBCentralManger: NSObject{
    
    //MARK: - Shared
    static let shared = BLEBCentralManger()
    //MARK: - Delegate
    weak var delegate : BLEBCentralManagerDelegate?
    weak var delegateSesion : BLEBSesionDelegate?
    //MARK: - Properties
    var peripheralsArray = [CBPeripheral]()
    var transferCharacteristic: CBCharacteristic?
    var divacePeripheral : CBPeripheral?
    var peripheralManager: CBPeripheralManager?
    var centralManager: CBCentralManager!

    //MARK: - Life Cycle
    private override init() {()}
    
    //MARK: - Methods
    func initCentralManger(){
        centralManager = CBCentralManager(delegate: self, queue: DispatchQueue.main)
    }

    func conectDivace(){
        guard let divacePeripheral = divacePeripheral else {return}
        centralManager.connect(divacePeripheral, options: nil)
        print("Conectarme al periférico....:: \(divacePeripheral)")
        BLEBPeripheralManager.shared.stopstopAdvertising()
        centralManager.stopScan()
    }
    
    func writeRespone(data: Data){
        guard let divacePeripheral = divacePeripheral else {return}
        divacePeripheral.writeValue(data, for: transferCharacteristic!, type: CBCharacteristicWriteType.withResponse)
    }
    func disconectPeripheral(){
        guard let divacePeripheral = divacePeripheral else {return}
        centralManager.cancelPeripheralConnection(divacePeripheral)
    }
    func scanPeripheral(){
        centralManager.scanForPeripherals(withServices: [BLEConstants.shared.serviceUUID], options: nil)
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) {_ in
        self.centralManager.stopScan()
        }
    }
}

// MARK: - CB Central Manager Delegate
extension BLEBCentralManger: CBCentralManagerDelegate {
    
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            print("Bluetooth encendido, buscando periféricos.")
            scanPeripheral()
        case .poweredOff:
            print("Bluetoth esta apagado ")
            delegate?.bluetoothOff(true)
//            delegateSesion?.bluetoothOff(true)

        
        default:
            print("Bluetooth needs to be powered on!")
        }
    }
    
    //Detectar servicios de los dispositivos y agregarlos en arreglo
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("\(peripheral.name ?? "")")
        delegate?.discoverPeripheral(peripheral)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Conectado a: \(peripheral.name ?? "")")
        peripheral.delegate = self
        peripheral.discoverServices([BLEConstants.shared.serviceUUID])
    }
}

// MARK: - Peripheral Delegate
extension BLEBCentralManger: CBPeripheralDelegate {
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        for service in services {
            print("Servicio encontrado: \(service)")
            peripheral.discoverCharacteristics([BLEConstants.shared.rxUUID], for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let serviceCharacteristics = service.characteristics else { return }
        for characteristic in serviceCharacteristics where characteristic.uuid == BLEConstants.shared.rxUUID {
            transferCharacteristic = characteristic
            peripheral.setNotifyValue(true, for: characteristic)
            delegate?.statePeripheral(true)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            print("La actualización del valor de la característica falló: \(error.localizedDescription)")
            return
        }
       
        guard let data = characteristic.value else { return }
        let message = (" \(peripheral.name ?? "") \(String(decoding: data, as: UTF8.self))")
        delegateSesion?.messageR(message)
        print("Mensaje recibido :\(message)")
    }
}
