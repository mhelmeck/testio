import Foundation

class HomeViewModel {
    
    // MARK: - Properties
    
    private let authService: AuthService
    
    // MARK: - Init
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    // MARK: - Methods
    
    @objc func filter() {
        
    }
    
    @objc func logout() {
        authService.logout()
    }
    
    func printServers() {
//        Task {
//            do {
//                let userSession = try await network.getSession(credentials: Credentials())
//                let servers = try await network.getServerList(token: userSession.token)
//                print("my_log servers: \(servers)")
//            } catch {
//                print("my_log error: \(error)")
//            }
//        }
    }
}
