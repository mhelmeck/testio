import Foundation

protocol LoginView: AnyObject {
    func showLoading()
    func hideLoading()
    func enableLoginButton()
    func disableLoginButton()
    func showLoginFailure(title: String, message: String)
}

class LoginPresenter {
    
    // MARK: - Properties
    
    var username = String() {
        didSet {
            updateLoginButton()
        }
    }
    
    var password = String() {
        didSet {
            updateLoginButton()
        }
    }
    
    private let authService: AuthService
    private weak var coordinator: LoginCoordinatorDelegate?
    private weak var view: LoginView?
    
    // MARK: - Init
    
    init(view: LoginView, coordinator: LoginCoordinatorDelegate, authService: AuthService) {
        self.view = view
        self.coordinator = coordinator
        self.authService = authService
        
        print("my_log init LoginViewModel")
    }
    
    deinit {
        print("my_log deinit LoginViewModel")
    }
    
    // MARK: - Methods
    
    func login() {
        guard let credentials = getValidatedCredentials() else {
            view?.showLoginFailure(title: "Verification Failed", message: "Your username or password is incorrect.")
            return
        }
        
        view?.showLoading()
        Task { @MainActor in
            do {
                try await authService.login(with: credentials)
                
                coordinator?.showHome()
                view?.hideLoading()
            } catch {
                view?.hideLoading()
                view?.showLoginFailure(title: "Login Failed", message: error.localizedDescription)
            }
        }
    }
    
    private func getValidatedCredentials() -> Credentials? {
        let credentials = Credentials(username: username, password: password)
        guard credentials.isValid() else {
            return nil
        }
        
        return credentials
    }
    
    private func updateLoginButton() {
        if username.isEmpty || password.isEmpty {
            view?.disableLoginButton()
        } else {
            view?.enableLoginButton()
        }
    }
}
