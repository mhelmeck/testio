import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    let viewModel: HomeViewModel
    
    // MARK: - Init
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        print("my_log init HomeViewController")
    }
    
    deinit {
        print("my_log deinit HomeViewController")
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
        title = "Testio."
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Filter", style: .done, target: viewModel, action: #selector(viewModel.filter))
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Logout", style: .done, target: viewModel, action: #selector(viewModel.logout))
    }
}
