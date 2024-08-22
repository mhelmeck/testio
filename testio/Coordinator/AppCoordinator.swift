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
        showLogin()
    }
    
    private func showHome() {
        let vc = HomeViewController()
        
        root.viewControllers = [vc]
    }
    
    private func showLogin() {
        let vm = LoginViewModel(network: dependencies.get())
        let vc = LoginViewController(viewModel: vm)
        
        root.viewControllers = [vc]
    }
}
