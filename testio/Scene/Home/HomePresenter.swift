import Foundation

class HomePresenter {
    
    // MARK: - Properties
    
    private let authService: AuthService
    private let serversService: ServersService
    private weak var coordinator: HomeCoordinatorDelegate?
    private weak var view: HomeView?
    
    // MARK: - Init
    
    init(
        view: HomeView,
        coordinator: HomeCoordinatorDelegate,
        authService: AuthService,
        serversService: ServersService
    ) {
        self.view = view
        self.coordinator = coordinator
        self.authService = authService
        self.serversService = serversService
        
        print("my_log init HomeViewModel")
        getServers()
    }
    
    deinit {
        print("my_log deinit HomeViewModel")
    }
    
    // MARK: - Methods
    
    func filter() {
        
    }
    
    func logout() {
        authService.logout()
        coordinator?.showLogin()
    }
    
    private func getServers() {
        view?.showLoading()
        Task { @MainActor in
            do {
                let servers = try await serversService.getServers()
                
                view?.hideLoading()
            } catch {
                view?.hideLoading()
                view?.showNetworkFailure(title: "Network error", message: error.localizedDescription)
            }
        }
    }
}
