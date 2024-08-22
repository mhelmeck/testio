import UIKit

class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController
    
    // MARK: - Init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    
    func start() {
        showLogin()
    }
    
    private func showHome() {
        let vc = HomeViewController()
        
        navigationController.viewControllers = [vc]
    }
    
    private func showLogin() {
        let network = Network()
        
        let vm = LoginViewModel(network: network)
        let vc = LoginViewController(viewModel: vm)
        navigationController.viewControllers = [vc]
    }
}
