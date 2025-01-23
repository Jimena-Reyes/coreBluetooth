//
//  BLEConstant.swift
//  BazBluetooth
//
//  Created by Usuario  on 19/08/24.
//

import CoreBluetooth

final class BLEConstants {
    //MARK: - Shared
    static let shared = BLEConstants()
    
    //MARK: - Properties
    let serviceUUID: CBUUID = CBUUID(string: "0000b81d-0000-1000-8000-00805f9b34fb")
    let rxUUID: CBUUID = CBUUID(string: "36d4dc5c-814b-4097-a5a6-b93b39085928")
    let rxProperties: CBCharacteristicProperties = [.notify, .write, .read]
    let rxPermissions: CBAttributePermissions = [.writeable, .readable]
    
    //MARK: - Life Cycle
    private init() {()}

}
