//
//  BLEBCentralPerip.swift
//  BazBluetooth
//
//  Created by Usuario Phinder2022 on 05/07/22.
//

import Foundation
import CoreBluetooth


protocol tranferMessa:AnyObject{
    
    func transferMessa(message: String)
}

class BLEBCentralPerip: BLEBCentralManger{
    var delegado : tranferMessa?
}

extension BLEBCentralPerip {
    
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
          
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            print("La actualización del valor de la característica falló: \(error.localizedDescription)")
            return
        }
        guard let data = characteristic.value else { return }
        let message = (" \(peripheral.name ?? "") \(String(decoding: data, as: UTF8.self))")
        delegado?.transferMessa(message: message)
//        messageTable.messaArray.append(message)
        print("Mensaje recibido :\(message)")
    }
    
}
