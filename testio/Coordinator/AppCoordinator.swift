import UIKit

class AppCoordinator: Coordinator, LoginCoordinatorDelegate, HomeCoordinatorDelegate {
    
    // MARK: - Properties
    
    let root: UINavigationController
    let dependencies: DependencyContainer
    
    // MARK: - Init
    
    init(root: UINavigationController, dependencies: DependencyContainer ) {
        self.root = root
        self.dependencies = dependencies
    }
    
    // MARK: - Methods
    
    func start() {
        let authService: AuthService = dependencies.get()
        if authService.isLoggedIn() {
            showHome()
        } else {
            showLogin()
        }
    }
    
    // MARK: - Api
    
    func showHome() {
        let vc = HomeViewController()
        let presenter = HomePresenter(
            view: vc,
            coordinator: self,
            authService: dependencies.get(),
            serversService: dependencies.get()
        )
        vc.presenter = presenter
        
        root.viewControllers = [vc]
    }
    
    func showLogin() {
        let vc = LoginViewController()
        let presenter = LoginPresenter(
            view: vc,
            coordinator: self,
            authService: dependencies.get()
        )
        vc.presenter = presenter
        
        root.viewControllers = [vc]
    }
}
