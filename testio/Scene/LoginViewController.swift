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
    }
    
    private func setupView() {
        title = "Testio."
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Logout", style: .done, target: viewModel, action: #selector(viewModel.logout))
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Login", style: .done, target: viewModel, action: #selector(viewModel.login))
    }
}
