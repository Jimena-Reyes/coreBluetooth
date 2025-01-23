//
//  BLEBTableView.swift
//  BazBluetooth
//
//  Created by Usuario  on 19/08/24.
//
import UIKit
import CoreBluetooth

// MARK: - Class
class BLEBListDivaces: UIView {
    
    //MARK: - Shared
    static let shared = BLEBListDivaces()
    //MARK: - Delegate
    weak var delegate : BLEBDivaceSelectDelegate?
    //MARK: - Properties
    var divacesArray: [CBPeripheral] = [] {
        didSet {
            divaTable.reloadData()
        }
    }
    
        lazy var divaTable: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.isUserInteractionEnabled = true
        table.backgroundColor = .white
        return table
    }()
    
    
    var divacePeripheral: CBPeripheral!
    //MARK: - Life Cycle
    
    //MARK: - Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
  
    }
}

extension BLEBListDivaces: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        divacesArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        100
    }
}

extension BLEBListDivaces: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = divacesArray[indexPath.row].name
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellSelect = divacesArray[indexPath.row]
        print("Seleccionaste \(cellSelect)")
        delegate?.divaceSelect(cellSelect)
    }

}
//MARK: - Private functions
extension BLEBListDivaces {
    private func commonInit() {
        setupConstraints()
        setupUI()
    }
    
    private func setupUI() {
       
    }
    
    private func setupConstraints() {
        self.addSubview(divaTable)
        divaTable.addAnchors(left: 0, top: 0, right: 0, bottom: 0)
    }
}
