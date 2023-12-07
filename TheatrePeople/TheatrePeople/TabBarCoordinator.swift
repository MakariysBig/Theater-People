import UIKit

protocol TabCoordinator: Coordinator {
    
    var tab: TabBarCoordinator.Tab { get }
    var rootViewController: UIViewController { get }
    
}

protocol MainTabBarCoordinatorCompletion: AnyObject {
    func finishFlow()
}

final class TabBarCoordinator: Coordinator {
    
    private weak var delegate: MainTabBarCoordinatorCompletion?
    private let navigationController: UINavigationController
    private let tabBarController: UITabBarController
    private(set) lazy var tabCoordinators: [TabCoordinator] = [
        EventCoordinator(),
        CalendarCoordinator(),
        AccountSettingsCoordinator()
    ]
    
    // MARK: - Initialise
    
    init(navigationController: UINavigationController, delegate: MainTabBarCoordinatorCompletion) {
        self.navigationController = navigationController
        self.delegate = delegate
        self.tabBarController = UITabBarController()
    }
    
    // MARK: - Open func
    
    func start() {
        setupTabBar()
        setupTabBarAppearance()
        
        navigationController.setViewControllers([tabBarController], animated: false)
    }
    
}

// MARK: - Private func

private extension TabBarCoordinator {
    
    func setupTabBar() {
        tabCoordinators.forEach { $0.start() }
        tabBarController.viewControllers = tabCoordinators.map { $0.rootViewController }
//        tabBarController.selectedViewController = tabCoordinators[Tab.account.rawValue].rootViewController
    }
    
    func setupTabBarAppearance() {
        tabBarController.tabBar.tintColor = .systemBlue
        tabBarController.tabBar.backgroundColor = .systemBackground
        tabBarController.navigationController?.navigationBar.isHidden = true
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13)]
        appearance.setTitleTextAttributes(attributes, for: .normal)
    }

}

extension TabBarCoordinator {
    
    enum Tab: Int {
        case events, calendar, account
    }
    
}

extension UITabBarItem {
    
    func configure(tab: TabBarCoordinator.Tab) {
        switch tab {     
        case .events:
            title = "Спектакли"
            image = UIImage(named: "event")
        case .calendar:
            title = "Календарь"
            image = UIImage(named: "calendar")
        case .account:
            title = "Профиль"
            image = UIImage(named: "user-profile")
        }
    }
    
}
