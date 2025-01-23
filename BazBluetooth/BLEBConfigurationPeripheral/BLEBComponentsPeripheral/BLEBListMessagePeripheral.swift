//
//  BLEBListPeripheral.swift
//  BazBluetooth
//
//  Created by Usuario  on 19/08/24.
//

import UIKit

// MARK: - Class
class BLEBListMessagePeripheral: UIView {
    
    //MARK: - Shared
    static let shared = BLEBListMessagePeripheral()

    //MARK: - Properties
    var messaArray: [String] = [] {
        didSet {
            responseTable.reloadData()
        }
    }
    
        lazy var responseTable: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .white
        return table
    }()

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

extension BLEBListMessagePeripheral: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messaArray.count
    }
}

extension BLEBListMessagePeripheral: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = messaArray[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        return cell
    }


}
//MARK: - Private functions
extension BLEBListMessagePeripheral {
    private func commonInit() {
        setupConstraints()
        setupUI()
    }
    
    private func setupUI() {
       
    }
    
    private func setupConstraints() {
        self.addSubview(responseTable)
       responseTable.addAnchors(left: 0, top: 0, right: 0, bottom: 0)
    }
}

