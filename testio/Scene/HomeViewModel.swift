import Foundation

class HomeViewModel {
    
    // MARK: - Properties
    
    private let network: Network
    
    // MARK: - Init
    
    init(network: Network) {
        self.network = network
    }
    
    // MARK: - Methods
    
    @objc func filter() {
        
    }
    
    @objc func logout() {
        
    }
    
    func printServers() {
        Task {
            do {
                let userSession = try await network.getSession(credentials: Credentials())
                let servers = try await network.getServerList(token: userSession.token)
                print("my_log servers: \(servers)")
            } catch {
                print("my_log error: \(error)")
            }
        }
    }
}
