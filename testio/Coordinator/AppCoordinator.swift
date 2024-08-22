import UIKit

class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var root: UINavigationController
    var dependencies: DependencyContainer
    
    // MARK: - Init
    
    init(root: UINavigationController, dependencies: DependencyContainer ) {
        self.root = root
        self.dependencies = dependencies
    }
    
    // MARK: - Methods
    
    func start() {
        showHome()
//        showLogin()
    }
    
    private func showHome() {
        let vm = HomeViewModel(network: dependencies.get())
        let vc = HomeViewController(viewModel: vm)
        
        root.viewControllers = [vc]
    }
    
    private func showLogin() {
        let vm = LoginViewModel(network: dependencies.get())
        let vc = LoginViewController(viewModel: vm)
        
        root.viewControllers = [vc]
    }
}
