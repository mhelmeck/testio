import Foundation

class LoginViewModel {
    
    // MARK: - Properties
    
    private let authService: AuthService
    
    // MARK: - Init
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    // MARK: - Methods
    
    @objc func login() {
        Task {
            do {
                try await authService.login(with: Credentials())
            } catch {
                print("my_log error: \(error)")
            }
        }
    }
}
