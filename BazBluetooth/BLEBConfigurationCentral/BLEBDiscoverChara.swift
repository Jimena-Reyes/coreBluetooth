//
//  BLEBDiscoverChara.swift
//  BazBluetooth
//
//  Created by Usuario Phinder2022 on 04/07/22.
//

import Foundation
import CoreBluetooth

extension BLEBCentralVc: CBPeripheralDelegate {

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
            delegate?.statePeripheral(state: true)
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            print("La actualización del valor de la característica falló: \(error.localizedDescription)")
            return
        }
        guard let data = characteristic.value else { return }
        let message = (" \(peripheral.name ?? "") \(String(decoding: data, as: UTF8.self))")
        print("Mensaje recibido :\(message)")
    }
}
