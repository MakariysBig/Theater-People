import UIKit

final class AccountSettingsCoordinator: TabCoordinator {
    
    var tab: TabBarCoordinator.Tab {
        .account
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
        let menuViewController = AccountViewController()
        navigationController.tabBarItem.configure(tab: tab)
        navigationController.setViewControllers([menuViewController], animated: false)
    }
    
}
