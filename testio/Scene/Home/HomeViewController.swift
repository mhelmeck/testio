import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: HomePresenter!
    
    private let backgroundImageView = buildImageView(
        name: "background.pdf",
        contentMode: .scaleAspectFill
    )
    
    private let activityIndicator = buildActivityIndicatorView()
    
    // MARK: - Init
    
    init() {
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
        installConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    private func setupView() {
        title = "Testio."
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: .done, target: self, action: #selector(filter))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(logout))
        
        [
            backgroundImageView,
            activityIndicator
        ].forEach(view.addSubview)
    }
    
    private func installConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func filter() {
        presenter.filter()
    }
    
    @objc private func logout() {
        presenter.logout()
    }
}

// MARK: - HomeView

extension HomeViewController: HomeView {
    func showLoading() {
        view.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        view.isUserInteractionEnabled = true
        activityIndicator.stopAnimating()
    }
    
    func showNetworkFailure(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
  
        present(alert, animated: true)
    }
}
