//
//  BLEBTableDelegate.swift
//  BazBluetooth
//
//  Created by Usuario  on 19/08/24.
//

import Foundation
import CoreBluetooth

protocol BLEBDivaceSelectDelegate: AnyObject {
    
    func divaceSelect(_ peripheral: CBPeripheral)
    
}
