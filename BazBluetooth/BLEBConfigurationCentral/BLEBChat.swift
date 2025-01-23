//
//  BLEBChat.swift
//  BazBluetooth
//
//  Created by Usuario Phinder2022 on 04/07/22.
//

import UIKit
import CoreBluetooth

class BLEBChat: UIViewController {
    
    lazy var divaceNameLabel : UILabel = {
       let label = UILabel()
        label.text = "Dispositivo conectado: iPhone"
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var tipoLabel : UILabel = {
        let label = UILabel()
        label.text = "Central / Periferico"
        label.textColor = .black
        return label
    }()
    
    lazy var messageTextField : UITextField = {
       let textField = UITextField()
        textField.placeholder = "Mensaje.."
        textField.textColor = .black
        textField.layer.borderWidth = 1
        textField.textAlignment = .center
        return textField
    }()

    
    let icon = UIImage(named: "enviar")
 
    var messageTable = BLEBMessageTableView()

    lazy var buttonSend : UIButton = {
        let button = UIButton()
        button.setImage(icon, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = greenColor
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = greenColor
        title = "Chat BLE"
        initUI()
        view.backgroundColor = .white
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)

    }
    
    @objc func dismissKeyboard() {
         view.endEditing(true)
     }
    
    func initUI(){
        
        view.addSubview(divaceNameLabel)
        divaceNameLabel.addAnchors(left: 20, top: 80, right: 20, bottom: nil)
        
        view.addSubview(tipoLabel)
        tipoLabel.addAnchors(left: 20, top: 10, right: 20, bottom: nil, withAnchor: .top, relativeToView: divaceNameLabel)
        
        view.addSubview(messageTable)
        messageTable.addAnchors(left: 0, top: 10, right: 0, bottom: 100, withAnchor: .top, relativeToView: tipoLabel)
        
        view.addSubview(messageTextField)
        messageTextField.addAnchorsAndSize(width: nil, height: 50, left: 10, top: 10, right: width / 2 - 90, bottom: nil, withAnchor: .top, relativeToView: messageTable)
        
        view.addSubview(buttonSend)
        buttonSend.addAnchorsAndSize(width: nil, height: 50, left: width / 2 + 100, top: 10, right: 10, bottom: nil,withAnchor: .top,relativeToView: messageTable)
    
    }
}
