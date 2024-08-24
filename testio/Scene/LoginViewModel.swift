import Foundation

class LoginViewModel {
    
    // MARK: - Properties
    
    private let authService: AuthService
    private weak var coordinator: LoginCoordinatorDelegate?

    // MARK: - Init
    
    init(coordinator: LoginCoordinatorDelegate, authService: AuthService) {
        self.coordinator = coordinator
        self.authService = authService
        
        print("my_log init LoginViewModel")
    }
    
    deinit {
        print("my_log deinit LoginViewModel")
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
