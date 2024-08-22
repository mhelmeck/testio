import Foundation

class LoginViewModel {
    
    // MARK: - Properties
    
    private let authService: AuthService
    private weak var coordinator: LoginCoordinatorDelegate?

    // MARK: - Init
    
    init(coordinator: LoginCoordinatorDelegate, authService: AuthService) {
        self.coordinator = coordinator
        self.authService = authService
    }
    
    // MARK: - Methods
    
    @objc func login() {
        Task { @MainActor in
            do {
                try await authService.login(with: Credentials())
                coordinator?.showHome()
            } catch {
                print("my_log error: \(error)")
            }
        }
    }
}
