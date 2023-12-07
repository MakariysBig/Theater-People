//
//  EventCoordinator.swift
//  TheatreScheduler
//
//  Created by Maksim Makarevich on 15.10.23.
//

import Foundation
import UIKit

final class EventCoordinator: TabCoordinator {
    
    var tab: TabBarCoordinator.Tab {
        .events
    }
    
    var rootViewController: UIViewController {
        navigationController
    }
    
    // MARK: - Properties
        
    var filterAccountWith: ((String) -> Void)?
    
    // MARK: - Private Properties
    
    private var childCoordinators = [Coordinator]()
    private let navigationController: UINavigationController

    // MARK: - Initialisers
    
    init() {
        self.navigationController = UINavigationController()
    }
    
    // MARK: - Open func
    
    func start() {
//        let menuViewModel = MenuViewModel(output: self, coordinatorDelegate: self)
        let menuViewController = EventViewController()
        navigationController.tabBarItem.configure(tab: tab)
        navigationController.setViewControllers([menuViewController], animated: false)
    }
    
}
