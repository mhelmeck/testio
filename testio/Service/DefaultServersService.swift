import Foundation

class DefaultServersService: ServersService {
    
    // MARK: - Properties
    
    private let network: Network
    private let storage: LocalStorage
    private let authService: AuthService
    
    // MARK: - Init
    
    init(network: Network, storage: LocalStorage, authService: AuthService) {
        self.network = network
        self.storage = storage
        self.authService = authService
        
        print("my_log init DefaultServersService")
    }
    
    deinit {
        print("my_log deinit DefaultServersService")
    }
    
    // MARK: - Api
    
    func getServers() async throws -> [Server] {
        let userSession = try authService.userSession()
        let request = try buildServersRequest(userSession: userSession)
        
        return try await network.getData(with: request)
    }
}

private extension DefaultServersService {
    func buildServersRequest(userSession: UserSession) throws -> URLRequest {
        guard let url = URL(string: "https://playground.tesonet.lt/v1/servers") else {
            throw ServersError.wrongUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(userSession.token)", forHTTPHeaderField: "Authorization")
        
        return request
    }
}
