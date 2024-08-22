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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    private func setupView() {
        view.backgroundColor = .systemBlue
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Login", style: .done, target: viewModel, action: #selector(viewModel.login))
    }
}
