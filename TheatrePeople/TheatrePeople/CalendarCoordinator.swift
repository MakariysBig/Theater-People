import Foundation
import UIKit

final class CalendarCoordinator: TabCoordinator {
    
    var tab: TabBarCoordinator.Tab {
        .calendar
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
        let viewModel = CalendarViewModel()
        let viewController = CalendarViewController(viewModel: viewModel)
        navigationController.tabBarItem.configure(tab: tab)
        navigationController.setViewControllers([viewController], animated: false)
    }
    
}
