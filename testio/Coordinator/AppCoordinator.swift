import UIKit

class AppCoordinator: Coordinator, LoginCoordinatorDelegate, HomeCoordinatorDelegate {
    
    // MARK: - Properties
    
    let root: UINavigationController
    let dependencies: DependencyContainer
    
    private let authService: AuthService
    
    // MARK: - Init
    
    init(root: UINavigationController, dependencies: DependencyContainer ) {
        self.root = root
        self.dependencies = dependencies
        self.authService = dependencies.get()
    }
    
    // MARK: - Methods
    
    func start() {
        if authService.isLoggedIn() {
            showHome()
        } else {
            showLogin()
        }
    }
    
    // MARK: - Api
    
    func showHome() {
        let vm = HomeViewModel(coordinator: self, authService: authService)
        let vc = HomeViewController(viewModel: vm)
        
        root.viewControllers = [vc]
    }
    
    func showLogin() {
        let vm = LoginViewModel(coordinator: self, authService: authService)
        let vc = LoginViewController(viewModel: vm)
        
        root.viewControllers = [vc]
    }
}
