//
//  ViewController.swift
//  BazBluetooth
//
//  Created by Usuario  on 19/08/24.
//

import UIKit

// MARK: - Class
class BLEBInitService: UIViewController {
    
    //MARK: - Properties
    lazy var startingServiceButton : UIButton = {
        let button = UIButton()
        button.setTitle("Encender", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = greenColor
        return button
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "CoreBluetooth"
        view.backgroundColor = .white
        initUI()
        
    }
    
    //MARK: - Methods
    func initUI(){
        view.addSubview(startingServiceButton)
        startingServiceButton.addAnchorsAndSize(width: nil, height: 50, left: 50, top: 100, right: 50, bottom: nil)
        startingServiceButton.addTarget(self, action: #selector(nextViewController), for: .touchUpInside)
    }
    
    @objc func nextViewController(){
        let vc = BLEBDiscover()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

