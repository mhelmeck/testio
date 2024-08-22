import Foundation

class PlaygroundNetwork: Network {
    
    // MARK: - Init
    
    init() {
        print("my_log init PlaygroundNetwork")
    }
    deinit {
        print("my_log deinit PlaygroundNetwork")
    }
    
    // MARK: - Api
    
    func getSession(credentials: Credentials) async throws -> UserSession {
        guard let url = URL(string: "https://playground.tesonet.lt/v1/tokens") else {
            throw NetworkError.wrongUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(credentials)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return try await execute(request)
    }
    
    func getServerList(token: String) async throws -> [Server] {
        guard let url = URL(string: "https://playground.tesonet.lt/v1/servers") else {
            throw NetworkError.wrongUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        return try await execute(request)
    }
    
    // MARK: - Methods
    
    private func execute<T: Decodable>(_ request: URLRequest) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.badServerResponse
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
