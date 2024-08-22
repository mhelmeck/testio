import Foundation

class HomeViewModel {
    
    // MARK: - Properties
    
    private let authService: AuthService
    private weak var coordinator: HomeCoordinatorDelegate?
    
    // MARK: - Init
    
    init(coordinator: HomeCoordinatorDelegate, authService: AuthService) {
        self.coordinator = coordinator
        self.authService = authService
    }
    
    // MARK: - Methods
    
    @objc func filter() {
        
    }
    
    @objc func logout() {
        authService.logout()
        coordinator?.showLogin()
    }
}
