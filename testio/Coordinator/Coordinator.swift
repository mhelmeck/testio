import UIKit

protocol Coordinator {
    var root: UINavigationController { get set }
    var dependencies: DependencyContainer { get set }

    func start()
}
