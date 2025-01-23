//
//  BLEAlertUtils.swift
//  BazBluetooth
//
//  Created by Usuario  on 19/08/24.
//

import UIKit

final class BLEAlertUtils {
    static func showSimpleAlert(from vc: UIViewController, msg: String) {
        let emptyAlert = UIAlertController(title: msg, message: nil, preferredStyle: .alert)
        
        emptyAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        vc.present(emptyAlert,animated: true,completion: nil )
    }
}
