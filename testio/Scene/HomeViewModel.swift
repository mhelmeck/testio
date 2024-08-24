import Foundation

class HomeViewModel {
    
    // MARK: - Properties
    
    private let authService: AuthService
    private let serversService: ServersService
    private weak var coordinator: HomeCoordinatorDelegate?
    
    // MARK: - Init
    
    init(coordinator: HomeCoordinatorDelegate, authService: AuthService, serversService: ServersService) {
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
    
    @objc func filter() {
        
    }
    
    @objc func logout() {
        authService.logout()
        coordinator?.showLogin()
    }
    
    private func getServers() {
        Task {
            try? await serversService.getServers()
        }
    }
}
