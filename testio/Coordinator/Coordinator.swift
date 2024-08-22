import UIKit

protocol Coordinator {
    var root: UINavigationController { get }
    var dependencies: DependencyContainer { get }

    func start()
}
