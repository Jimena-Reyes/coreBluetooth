//
//  BLEBPeripheralDelegate.swift
//  BazBluetooth
//
//  Created by Usuario  on 19/08/24.
//

import Foundation

protocol BLEBPeripheralDelegate: AnyObject {
    func onConection(_ conection: Bool)
    func messageResponse(_ message: String)
    func bluetoothOff(_ bluetoothOff: Bool)
}
