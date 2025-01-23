//
//  BLEBMessageTableView.swift
//  BazBluetooth
//
//  Created by Usuario  on 19/08/24.
//

import UIKit

// MARK: - Class
class BLEBListMessageCentral: UIView {
    
    //MARK: - Shared
    static let shared = BLEBListMessageCentral()

    //MARK: - Properties
    var messaArray: [String] = [] {
        didSet {
            daTable.reloadData()
        }
    }
    
        lazy var daTable: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .white
        return table
    }()

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

extension BLEBListMessageCentral: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messaArray.count
    }
}

extension BLEBListMessageCentral: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = messaArray[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        return cell
    }


}
//MARK: - Private functions
extension BLEBListMessageCentral {
    private func commonInit() {
        setupConstraints()
        setupUI()
    }
    
    private func setupUI() {
       
    }
    
    private func setupConstraints() {
        self.addSubview(daTable)
       daTable.addAnchors(left: 0, top: 0, right: 0, bottom: 0)
    }
}
