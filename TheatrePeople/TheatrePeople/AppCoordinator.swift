import UIKit

// MARK: - Protocols

protocol Coordinator {
    func start()
}

final class AppCoordinator: Coordinator {
    
    // MARK: - Private Properties
    
    private let navigationController: UINavigationController
    private var childCoordinators = [Coordinator]()
    
    // MARK: - Initializers
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    
    func start() {
        let isUserLogin = true
        
        if isUserLogin {
            let coordinator = TabBarCoordinator(navigationController: navigationController,
                                                delegate: self)
            coordinator.start()
            navigationController.navigationBar.isHidden = true
            childCoordinators.append(coordinator)
        }
    }
    
}

// MARK: - MainTabBarCoordinatorCompletion

extension AppCoordinator: MainTabBarCoordinatorCompletion {
    
    func finishFlow() {
        
    }
    
}
