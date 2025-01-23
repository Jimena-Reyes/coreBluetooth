//
//  BLEBChatVC.swift
//  BazBluetooth
//
//  Created by Usuario Phinder2022 on 29/06/22.
//

import UIKit

class BLEBChatVC: UIViewController {
    
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

    lazy var messageTable : UITableView = {
       let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .white
        return table
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
    
    var messageArray = ["Hola","Prueba","Hola 2"]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = greenColor
        title = "Chat BLE"
        view.backgroundColor = .white
        initUI()

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

extension BLEBChatVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = messageArray[indexPath.row]
        return cell
    }
}

