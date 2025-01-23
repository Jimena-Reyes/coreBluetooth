//
//  BLEBChat.swift
//  BazBluetooth
//
//  Created by Usuario Phinder2022 on 05/07/22.
//
import UIKit
import CoreBluetooth

// MARK: - Class
class BLEBChatCentral: UIViewController {
    
    //MARK: - Properties
    lazy var divaceNameLabel : UILabel = {
       let label = UILabel()
        label.text = "Dispositivo conectado: "
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var tipoLabel : UILabel = {
        let label = UILabel()
        label.text = "Central"
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

    lazy var buttonSend : UIButton = {
        let button = UIButton()
        button.setImage(icon, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = greenColor
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return button
    }()

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = greenColor
        title = "Chat BLE"
        view.backgroundColor = .white
        initUI()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    //MARK: - Methods
    @objc func dismissKeyboard() {
         view.endEditing(true)
     }
    
    func initUI(){
        
        BLEBCentralManger.shared.delegate = self
        
        view.addSubview(divaceNameLabel)
        divaceNameLabel.addAnchors(left: 20, top: 80, right: 20, bottom: nil)
        
        view.addSubview(tipoLabel)
        tipoLabel.addAnchors(left: 20, top: 10, right: 20, bottom: nil, withAnchor: .top, relativeToView: divaceNameLabel)
        
        view.addSubview(BLEBListDataC.shared.daTable)
        BLEBListDataC.shared.daTable.addAnchors(left: 0, top: 10, right: 0, bottom: 100, withAnchor: .top, relativeToView: tipoLabel)
        
        view.addSubview(messageTextField)
        messageTextField.addAnchorsAndSize(width: nil, height: 50, left: 10, top: 10, right: width / 2 - 90, bottom: nil, withAnchor: .top, relativeToView: BLEBListDataC.shared.daTable)
        
        view.addSubview(buttonSend)
        buttonSend.addAnchorsAndSize(width: nil, height: 50, left: width / 2 + 100, top: 10, right: 10, bottom: nil,withAnchor: .top,relativeToView: BLEBListDataC.shared.daTable)
        
        buttonSend.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        
    }
    
    @objc private func sendMessage(){
        if messageTextField.text != "" {
                if let messageText = messageTextField.text {
                guard let data = messageText.data(using: .utf8) else { return }
                    BLEBCentralManger.shared.writeRespone(data: data)
                    BLEBListDataC.shared.messaArray.append(messageText)
                    messageTextField.text = ""
                }
        }else{
            let emptyAlert = UIAlertController(title: "No se ha ingresado ningun texto", message: nil, preferredStyle: .alert)
            emptyAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(emptyAlert,animated: true,completion: nil )
        }
    }
}

extension BLEBChatCentral: BLEBCentralManagerDelegate{
    func divaceConected(_ peripheral: CBPeripheral) {
        divaceNameLabel.text = "Dispositivo conectado a: \(peripheral.name ?? "") "
    }
    
    func transferPeripheral(_ peripheral: CBPeripheral) {
   
    }
    
    func statePeripheral(_ state: Bool) {
        
    }
    
    func messageTranfer(_ message: String) {
        BLEBListDataC.shared.messaArray.append(message)
    }
 
}

