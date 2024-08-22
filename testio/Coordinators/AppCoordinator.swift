import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showLogin()
    }
    
    private func showHome() {
        let vc = HomeViewController()
        navigationController.viewControllers = [vc]
    }
    
    private func showLogin() {
        let vc = LoginViewController()
        navigationController.viewControllers = [vc]
    }
}
