protocol AuthService {
    func login(with credentials: Credentials) async throws
    func logout()
    func isLoggedIn() -> Bool
}

class DefaultAuthService: AuthService {
    
    // MARK: - Properties
   
    private let network: Network
    private let storage: Storage
   
    
    // MARK: - Init
    
    init(network: Network, storage: Storage) {
        self.network = network
        self.storage = storage
    }
    
    // MARK: - Api
    
    func login(with credentials: Credentials) async throws {
        let userSession = try await network.getSession(credentials: credentials)
        storage.writeToken(userSession.token)
    }
    
    func logout() {
        storage.deleteToken()
    }
    
    func isLoggedIn() -> Bool {
        guard let token = storage.readToken() else {
            return false
        }
        
        return !token.isEmpty
    }
}
