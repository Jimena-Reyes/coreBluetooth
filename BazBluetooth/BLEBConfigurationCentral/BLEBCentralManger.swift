//
//  BLEBCentralVc.swift
//  BazBluetooth
//
//  Created by Usuario Phinder2022 on 30/06/22.
//


//import UIKit
//import CoreBluetooth
//
//// MARK: - Class
//
//class BLEBCentralManger: UIViewController {
//    
//    static let shared = BLEBCentralManger()
//
//    weak var delegate : transferPeripheral?
//    
//    var peripheralsArray = [CBPeripheral]()
//    var transferCharacteristic: CBCharacteristic?
//    var divacePeripheral: CBPeripheral!
//    var peripheralManager: CBPeripheralManager!
//    var centralManager: CBCentralManager!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//   
//    }
//
//    func initCentralManger(){
//        centralManager = CBCentralManager(delegate: self, queue: DispatchQueue.main)
//
//    }
//
//    func conectDivace(){
//        centralManager.connect(divacePeripheral, options: nil)
//        print("Conectarme al periférico....:: \(divacePeripheral!)")
//    }
//}
//
//
//// MARK: - CB Central Manager Delegate
//extension BLEBCentralManger: CBCentralManagerDelegate {
//    
//    func centralManagerDidUpdateState(_ central: CBCentralManager) {
//        switch central.state {
//        case .poweredOn:
//            print("Bluetooth encendido, buscando periféricos.")
//            centralManager.scanForPeripherals(withServices: [BLEConstants.shared.serviceUUID], options: nil)
//        case .poweredOff:
//            let emptyAlert = UIAlertController(title: "Enciende el Bluetooth", message: nil, preferredStyle: .alert)
//            emptyAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//            self.present(emptyAlert,animated: true,completion: nil )
//        default:
//            print("Bluetooth needs to be powered on!")
//        }
//    }
//    
//    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
//        print("\(peripheral.name ?? "")")
//        delegate?.transferPeripheral(peripheral: peripheral)
//    }
//    
//    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
//        print("Conectado a: \(peripheral.name ?? "")")
//        peripheral.delegate = self
//        peripheral.discoverServices([BLEConstants.shared.serviceUUID])
//        delegate?.statePeripheral(state: true)
//    }
//}
//
//
//// MARK: - Peripheral Delegate
//
//extension BLEBCentralManger: CBPeripheralDelegate {
//    
//    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
//        guard let services = peripheral.services else { return }
//        for service in services {
//            print("Servicio encontrado: \(service)")
//            peripheral.discoverCharacteristics([BLEConstants.shared.rxUUID], for: service)
//        }
//    }
//    
//    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
//        guard let serviceCharacteristics = service.characteristics else { return }
//        for characteristic in serviceCharacteristics where characteristic.uuid == BLEConstants.shared.rxUUID {
//            transferCharacteristic = characteristic
//            peripheral.setNotifyValue(true, for: characteristic)
//        }
//    }
//    
//    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
//        if let error = error {
//            print("La actualización del valor de la característica falló: \(error.localizedDescription)")
//            return
//        }
//        guard let data = characteristic.value else { return }
//        let message = (" \(peripheral.name ?? "") \(String(decoding: data, as: UTF8.self))")
//        delegate?.messageTranfer(message: message)
////        messageTable.messaArray.append(message)
//        print("Mensaje recibido :\(message)")
//    }
//}
