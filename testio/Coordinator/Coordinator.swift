import UIKit

protocol Coordinator {
    var root: UINavigationController { get }
    var dependencies: DependencyContainer { get }

    func start()
}

protocol LoginCoordinatorDelegate: AnyObject {
    func showHome()
}

protocol HomeCoordinatorDelegate: AnyObject {
    func showLogin()
}
