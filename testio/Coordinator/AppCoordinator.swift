import UIKit

class AppCoordinator: Coordinator, LoginCoordinatorDelegate, HomeCoordinatorDelegate {
    
    // MARK: - Properties
    
    let root: UINavigationController
    let dependencies: DependencyContainer
    
    // MARK: - Init
    
    init(root: UINavigationController, dependencies: DependencyContainer ) {
        self.root = root
        self.dependencies = dependencies
        
        print("my_log init AppCoordinator")
    }
    
    deinit {
        print("my_log deinit AppCoordinator")
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
        let vm = HomeViewModel(
            coordinator: self,
            authService: dependencies.get(),
            serversService: dependencies.get()
        )
        let vc = HomeViewController(viewModel: vm)
        
        root.viewControllers = [vc]
    }
    
    func showLogin() {
        let vm = LoginViewModel(
            coordinator: self,
            authService: dependencies.get()
        )
        let vc = LoginViewController(viewModel: vm)
        
        root.viewControllers = [vc]
    }
}
