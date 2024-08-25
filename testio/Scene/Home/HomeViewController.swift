import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: HomePresenter!
    var headerView: HomeHeaderView?

    private var dataSource: DataSource!

    private let collectionView = buildListCollectionView()
    
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
        
        setupCollectionView()
        setupView()
        installConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    private func setupCollectionView() {
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        dataSource = DataSource(collectionView: collectionView) { 
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Server.ID) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration(
            elementKind: HomeHeaderView.elementKind,
            handler: supplementaryRegistrationHandler
        )
        dataSource.supplementaryViewProvider = { supplementaryView, elementKind, indexPath in
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        }
        
        collectionView.dataSource = dataSource
        collectionView.delegate = self
    }
    
    private func setupView() {
        title = "Testio."
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filter))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        
        [
            backgroundImageView,
            collectionView,
            activityIndicator
        ].forEach(view.addSubview)
    }
    
    private func installConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
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
    func updateSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(presenter.servers.map { $0.id })
        
        dataSource.apply(snapshot)
    }
    
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

// MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return false
    }
}
