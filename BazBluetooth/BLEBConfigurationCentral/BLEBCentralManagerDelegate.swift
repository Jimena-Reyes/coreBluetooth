//
//  BLEBCentralDelegate.swift
//  BazBluetooth
//
//  Created by Usuario  on 19/08/24.
//

import Foundation
import CoreBluetooth

protocol BLEBCentralManagerDelegate: AnyObject {
    
    func discoverPeripheral(_ peripheral: CBPeripheral)
    func statePeripheral(_ state: Bool)
    func messageCentral(_ message: String)
    func divaceConected(_ peripheral: CBPeripheral)
    func bluetoothOff(_ bluetoothOff: Bool)
}
