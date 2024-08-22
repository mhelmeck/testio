class DefaultAuthService: AuthService {
    
    // MARK: - Properties
   
    private let network: Network
    private let storage: Storage
   
    // MARK: - Init
    
    init(network: Network, storage: Storage) {
        self.network = network
        self.storage = storage
        
        print("my_log init DefaultAuthService")
    }
    
    deinit {
        print("my_log deinit DefaultAuthService")
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
