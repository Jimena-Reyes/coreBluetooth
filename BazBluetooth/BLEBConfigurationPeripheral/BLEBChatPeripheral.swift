//
//  BLEBChatPeripheral.swift
//  BazBluetooth
//
//  Created by Usuario  on 19/08/24.
//
import UIKit

// MARK: - Class
class BLEBChatPeripheral: UIViewController {
    
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
        label.text = "Periferico"
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
        title = "Chat BLE"
        view.backgroundColor = .white
        initUI()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        self.keyboardCheck()
        self.navigationItem.hidesBackButton = true
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Desconectar", style: .plain, target: self, action: #selector(addTapped))

    }
    
    //MARK: - Methods
    @objc func addTapped(){
        BLEBPeripheralManager.shared.cancelConnection()
        let vc = BLEBDiscover()
        self.navigationController?.pushViewController(vc, animated: true)
     }

    @objc func dismissKeyboard() {
         view.endEditing(true)
     }
    
    func initUI(){
        
        BLEBPeripheralManager.shared.delegate = self
        
        view.addSubview(divaceNameLabel)
        divaceNameLabel.addAnchors(left: 20, top: 100, right: 20, bottom: nil)
        
        view.addSubview(tipoLabel)
        tipoLabel.addAnchors(left: 20, top: 10, right: 20, bottom: nil, withAnchor: .top, relativeToView: divaceNameLabel)
        
        view.addSubview(BLEBListMessagePeripheral.shared.responseTable)
        BLEBListMessagePeripheral.shared.responseTable.addAnchors(left: 0, top: 10, right: 0, bottom: 100, withAnchor: .top, relativeToView: tipoLabel)
        
        view.addSubview(messageTextField)
        messageTextField.addAnchorsAndSize(width: nil, height: 50, left: 10, top: 10, right: width / 2 - 90, bottom: nil, withAnchor: .top, relativeToView:BLEBListMessagePeripheral.shared.responseTable)
        
        view.addSubview(buttonSend)
        buttonSend.addAnchorsAndSize(width: nil, height: 50, left: width / 2 + 100, top: 10, right: 10, bottom: nil,withAnchor: .top,relativeToView: BLEBListMessagePeripheral.shared.responseTable)
        
        buttonSend.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        
    }
    
    @objc func sendMessage() {
        guard let messageText = messageTextField.text,
              messageText != "",
              let data = messageText.data(using: .utf8) else {
                  BLEAlertUtils.showSimpleAlert(from: self, msg: "No se ha ingresado ningun texto")
            return
        }
        BLEBPeripheralManager.shared.writeRespone(data: data)
        BLEBListMessagePeripheral.shared.messaArray.append(messageText)
        messageTextField.text = ""
    }
}

extension BLEBChatPeripheral: BLEBPeripheralDelegate{
    func bluetoothOff(_ bluetoothOff: Bool) {
        if bluetoothOff{
            BLEAlertUtils.showSimpleAlert(from: self, msg: "Se cerro la conexion")
        
        }
    }
    
    func onConection(_ conection: Bool) {
        if conection != true{
            let vc = BLEBDiscover()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func messageResponse(_ message: String) {
        BLEBListMessagePeripheral.shared.messaArray.append(message)
    }
}

