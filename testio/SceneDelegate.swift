import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: - Properties
    
    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    // MARK: - Methods
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let root = createAndSetupRoot()
        let dependencies = createAndSetupDependencies()
        
        appCoordinator = AppCoordinator(root: root, dependencies: dependencies)
        appCoordinator?.start()
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = root
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}

extension SceneDelegate {
    private func createAndSetupRoot() -> UINavigationController {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        return UINavigationController()
    }
    
    private func createAndSetupDependencies() -> DependencyContainer {
        let dependencies = DependencyContainer()
        dependencies.register(dependency: PlaygroundNetwork(), for: Network.self)
        dependencies.register(dependency: UserDefaultStorage(), for: Storage.self)
        dependencies.register(dependency: DefaultSessionService(storage: dependencies.get()), for: SessionService.self)
        
        return dependencies
    }
}
