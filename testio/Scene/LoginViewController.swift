import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    let viewModel: LoginViewModel
    
    // MARK: - Init
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        viewModel.printServers()
    }
    
    private func setupView() {
        title = "Login"
        view.backgroundColor = .systemBlue
    }
}

import Foundation

class LoginViewModel {
    
    // MARK: - Properties
    let network: Networking
    
    // MARK: - Init
    
    init(network: Networking) {
        self.network = network
    }
    
    // MARK: - Methods
    
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
