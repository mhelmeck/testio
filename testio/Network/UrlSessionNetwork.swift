import Foundation

class UrlSessionNetwork: Network {
    
    // MARK: - Init
    
    init() {
        print("my_log init UrlSessionNetwork")
    }
    deinit {
        print("my_log deinit UrlSessionNetwork")
    }
    
    // MARK: - Api
    
    func get<T: Decodable>(with request: URLRequest) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.badServerResponse
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
