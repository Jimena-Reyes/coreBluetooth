//
//  BLEBChatCentral.swift
//  BazBluetooth
//
//  Created by Usuario  on 19/08/24.
//
import UIKit
import CoreBluetooth

// MARK: - Class
class BLEBChatCentral: UIViewController {
    
    //MARK: - Properties
    lazy var divaceNameLabel : UILabel = {
       let label = UILabel()
        label.text = "Dispositivo conectado a: \(BLEBCentralManger.shared.divacePeripheral?.name ?? "") "
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
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return button
    }()

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chat BLE"
        view.backgroundColor = .white
        initUI()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        self.navigationItem.hidesBackButton = true
        self.keyboardCheck()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Desconectar", style: .plain, target: self, action: #selector(addTapped))
    }
    
    //MARK: - Methods
    @objc func addTapped(){
        BLEBCentralManger.shared.disconectPeripheral()
        let vc = BLEBDiscover()
        self.navigationController?.pushViewController(vc, animated: true)
     }
    
    @objc func dismissKeyboard() {
         view.endEditing(true)
     }
    
    func initUI(){
        
        BLEBCentralManger.shared.delegateSesion = self
        
        view.addSubview(divaceNameLabel)
        divaceNameLabel.addAnchors(left: 20, top: 100, right: 20, bottom: nil)
        
        view.addSubview(tipoLabel)
        tipoLabel.addAnchors(left: 20, top: 10, right: 20, bottom: nil, withAnchor: .top, relativeToView: divaceNameLabel)
        
        view.addSubview(BLEBListMessageCentral.shared.daTable)
        BLEBListMessageCentral.shared.daTable.addAnchors(left: 0, top: 10, right: 0, bottom: 100, withAnchor: .top, relativeToView: tipoLabel)
        
        view.addSubview(messageTextField)
        messageTextField.addAnchorsAndSize(width: nil, height: 50, left: 10, top: 10, right: width / 2 - 90, bottom: nil, withAnchor: .top, relativeToView: BLEBListMessageCentral.shared.daTable)
        
        view.addSubview(buttonSend)
        buttonSend.addAnchorsAndSize(width: nil, height: 50, left: width / 2 + 100, top: 10, right: 10, bottom: nil,withAnchor: .top,relativeToView: BLEBListMessageCentral.shared.daTable)
        
        buttonSend.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        
    }
    
    @objc private func sendMessage(){
        if messageTextField.text != "" {
                if let messageText = messageTextField.text {
                guard let data = messageText.data(using: .utf8) else { return }
                    BLEBCentralManger.shared.writeRespone(data: data)
                    BLEBListMessageCentral.shared.messaArray.append(messageText)
                    messageTextField.text = ""
                }
        }else{
            BLEAlertUtils.showSimpleAlert(from: self, msg: "No se ha ingresado nungun texto")
        }
    }
}


extension BLEBChatCentral: BLEBSesionDelegate{
    func bluetoothOff(_ bluetoothOff: Bool) {
        if bluetoothOff{
            BLEAlertUtils.showSimpleAlert(from: self, msg: "")
            let vc = BLEBDiscover()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func messageR(_ message: String) {
        BLEBListMessageCentral.shared.messaArray.append(message)
    }
}
