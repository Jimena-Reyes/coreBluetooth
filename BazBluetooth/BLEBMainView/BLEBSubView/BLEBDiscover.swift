//
//  DBBluetoothVC.swift
//  BazBluetooth
//
//  Created by Usuario  on 19/08/24.
//
import UIKit
import CoreBluetooth

// MARK: - Class
class BLEBDiscover: UIViewController, UISearchBarDelegate, CBPeripheralDelegate {
    
    //MARK: - Shared
    static let shared = BLEBDiscover()
    //MARK: - Properties
    lazy var divaceNameLabel : UILabel = {
       let label = UILabel()
        label.text = "Dispositivo: \(UIDevice.current.name)"
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var textLabel : UILabel = {
        let label = UILabel()
        label.text = "DISPOSITIVOS"
        label.textColor = .black
        return label
    }()
    
    let icon = UIImage(named: "reload")

    lazy var buttonRefrsh : UIButton = {
        let button = UIButton()
        button.setImage(icon, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return button
    }()
    
    lazy var activityIndicator : UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.color = .black
        activity.center = view.center
        return activity
    }()
    
    lazy var activityIndicatorScan : UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.color = .black
        activity.center = view.center
        return activity
    }()
    

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Core BLE"
        view.backgroundColor = .white
        initUI()
        initCentralManager()
        self.navigationItem.hidesBackButton = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    //MARK: - Methods
    @objc func dismissKeyboard() {
         view.endEditing(true)
     }
    
    func initCentralManager(){
        BLEBCentralManger.shared.initCentralManger()
    }
    
    func initUI(){

        BLEBCentralManger.shared.delegate = self
        BLEBListDivaces.shared.delegate = self
        
        BLEBPeripheralManager.shared.initPeripheralManager()
        BLEBPeripheralManager.shared.delegate = self

        
        view.addSubview(divaceNameLabel)
        divaceNameLabel.addAnchors(left: 20, top: 100, right: 20, bottom: nil)
        
        view.addSubview(textLabel)
        textLabel.addAnchors(left: 10, top: 50, right: width / 2, bottom: nil, withAnchor: .top, relativeToView: divaceNameLabel)
        
        view.addSubview(activityIndicatorScan)
        activityIndicatorScan.addAnchorsAndSize(width: 40, height: 40, left: nil, top: 30, right: 120, bottom: nil, withAnchor: .top, relativeToView: divaceNameLabel)
        
        view.addSubview(buttonRefrsh)
        buttonRefrsh.addAnchorsAndSize(width: 50, height: 50, left: nil, top: 30, right: 70, bottom: nil, withAnchor: .top, relativeToView: divaceNameLabel)
        
        view.addSubview(BLEBListDivaces.shared.divaTable)
        BLEBListDivaces.shared.divaTable.addAnchors(left: 0, top: 10, right: 0, bottom: 100, withAnchor: .top, relativeToView: textLabel)
        
        view.addSubview(activityIndicator)
        
        buttonRefrsh.addTarget(self, action: #selector(refreshList), for: .touchUpInside)

    }
    
    @objc func refreshList(){
        if BLEBCentralManger.shared.centralManager.state  == .poweredOff {
            BLEAlertUtils.showSimpleAlert(from: self, msg: "Enciende el bluetooth para poder usar la aplicacion")

        }else{
            
            BLEBListDivaces.shared.divacesArray.removeAll()
            BLEBCentralManger.shared.scanPeripheral()
            activityIndicatorScan.startAnimating()
            Timer.scheduledTimer(withTimeInterval: 5, repeats: false) {_ in
                self.activityIndicatorScan.stopAnimating()
            }
        }
    }
}

extension BLEBDiscover: BLEBPeripheralDelegate{
    func messageResponse(_ message: String) {
        
    }
    
    func onConection(_ conection: Bool) {
        if conection{
            activityIndicator.stopAnimating()
            let vc = BLEBChatPeripheral()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension BLEBDiscover : BLEBCentralManagerDelegate{
    func bluetoothOff(_ bluetoothOff: Bool) {
        if bluetoothOff{
            BLEAlertUtils.showSimpleAlert(from: self, msg: "Se perdio la conexio ")
        }
    }
    
    func divaceConected(_ peripheral: CBPeripheral) {
        
    }
    
    func messageCentral(_ message: String) {
    }
    

    func statePeripheral(_ state: Bool) {
        if state {
            activityIndicator.stopAnimating()
            let vc = BLEBChatCentral()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func discoverPeripheral(_ peripheral: CBPeripheral) {
        if BLEBListDivaces.shared.divacesArray.contains(peripheral) {
            print("Dispositivo duplicado")
        }else{
            BLEBListDivaces.shared.divacesArray.append(peripheral)
        }
    }
}

extension BLEBDiscover : BLEBDivaceSelectDelegate{
    func divaceSelect(_ peripheral: CBPeripheral) {
        
        let connectActionSheet = UIAlertController(title: "Te quieres conectar a \(peripheral.name ?? "") ", message: nil, preferredStyle: .actionSheet)
        connectActionSheet.addAction(UIAlertAction(title: "Conectar", style: .destructive, handler: { [self](action:UIAlertAction) in
            BLEBCentralManger.shared.divacePeripheral = peripheral
            BLEBCentralManger.shared.delegate = self
            BLEBCentralManger.shared.conectDivace()
            activityIndicator.startAnimating()
        }))
        connectActionSheet.addAction((UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)))
        self.present(connectActionSheet, animated: true, completion: nil )
    }

}
