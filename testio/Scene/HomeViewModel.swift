import Foundation

class HomeViewModel {
    
    // MARK: - Properties
    
    private let authService: AuthService
    private weak var coordinator: HomeCoordinatorDelegate?
    
    // MARK: - Init
    
    init(coordinator: HomeCoordinatorDelegate, authService: AuthService) {
        self.coordinator = coordinator
        self.authService = authService
        
        print("my_log init HomeViewModel")
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
}
