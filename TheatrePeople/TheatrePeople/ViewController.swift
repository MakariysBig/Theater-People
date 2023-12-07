//
//  ViewController.swift
//  TheatrePeople
//
//  Created by Maksim Makarevich on 07.12.2023.
//

import UIKit
import NetworkKit

class ViewController: UIViewController {
    
    private let networkService: NetworkProtocol = NetworkManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        networkService.getCrypto(pair: "btc") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                print(data)
            case .failure(_):
                print("error")
            }
        }
    }
    
}



