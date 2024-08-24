import Foundation

class DefaultAuthService: AuthService {
    
    // MARK: - Properties
   
    private let network: Network
    private let storage: SecureStorage
    
    private let userSessionKey = "user_session_key"
   
    // MARK: - Init
    
    init(network: Network, storage: SecureStorage) {
        self.network = network
        self.storage = storage
        
        print("my_log init DefaultAuthService")
    }
    
    deinit {
        print("my_log deinit DefaultAuthService")
    }
    
    // MARK: - Api
    
    func login(with credentials: Credentials) async throws {
        let request = try buildLoginRequest(credentials: credentials)
        let userSession: UserSession = try await network.getData(with: request)
        storage.write(userSession, forKey: userSessionKey)
    }
    
    func logout() {
        storage.delete(forKey: userSessionKey)
    }

    func isLoggedIn() -> Bool {
        guard let userSession = try? userSession() else {
            return false
        }
        
        return !userSession.token.isEmpty
    }
    
    func userSession() throws -> UserSession {
        guard let userSession: UserSession = storage.read(forKey: userSessionKey) else {
            throw AuthError.noValidToken
        }
        
        return userSession
    }
}

private extension DefaultAuthService {
    func buildLoginRequest(credentials: Credentials) throws -> URLRequest {
        guard let url = URL(string: "https://playground.tesonet.lt/v1/tokens") else {
            throw AuthError.wrongUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(credentials)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
}
