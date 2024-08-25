import Foundation

class HomePresenter {
    enum FilterType {
        case distance
        case alphabetical
        case none
    }
    
    // MARK: - Properties
    
    private var servers: [Server] = []
    var filteredServers: [Server] = []
    
    var filterType: FilterType = .none {
        didSet {
            filter()
        }
    }
    
    private let authService: AuthService
    private let serversService: ServersService
    private weak var coordinator: HomeCoordinatorDelegate?
    private weak var view: HomeView?
    
    // MARK: - Init
    
    init(
        view: HomeView,
        coordinator: HomeCoordinatorDelegate,
        authService: AuthService,
        serversService: ServersService
    ) {
        self.view = view
        self.coordinator = coordinator
        self.authService = authService
        self.serversService = serversService
        
        print("my_log init HomeViewModel")
        getServers()
    }
    
    deinit {
        print("my_log deinit HomeViewModel")
    }
    
    // MARK: - Methods
        
    func logout() {
        authService.logout()
        coordinator?.showLogin()
    }
    
    func server(withId id: Server.ID) -> Server {
        let index = servers.indexOfServer(withId: id)
        return servers[index]
    }
    
    private func getServers() {
        view?.showLoading()
        
        Task { @MainActor in
            do {
                servers = try await serversService.getServers()
                filteredServers = servers
                
                view?.updateSnapshot()
                view?.hideLoading()
            } catch {
                view?.hideLoading()
                view?.showNetworkFailure(title: "Network error", message: error.localizedDescription)
            }
        }
    }
    
    private func filter() {
        switch filterType {
        case .distance:
            filteredServers = servers.sorted(by: { $0.distance < $1.distance })
        case .alphabetical:
            filteredServers = servers.sorted(by: { $0.name < $1.name })
        case .none:
            break
        }
        
        view?.updateSnapshot()
    }
}
