import UIKit

class HomeViewController: UIViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Server.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Server.ID>
    
    // MARK: - Properties
    
    var presenter: HomePresenter!

    private var collectionView: UICollectionView!
    private var dataSource: DataSource!
    
    private let backgroundImageView = buildImageView(
        name: "background.pdf",
        contentMode: .scaleAspectFill
    )
    
    private let activityIndicator = buildActivityIndicatorView()
    
    // MARK: - Init
    
    init() {
        super.init(nibName: nil, bundle: nil)
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
        collectionView = UIViewController.buildListCollectionView()
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Server.ID> { [weak self] (cell, _, item) in
            guard let server = self?.presenter.server(withId: item) else {
                return
            }
            
            var contentConfiguration = cell.homeCellConfiguration()
            contentConfiguration.server = server.name
            contentConfiguration.distance = server.distance
            
            cell.contentConfiguration = contentConfiguration
        }
        dataSource = DataSource(collectionView: collectionView) { (collectionView, indexPath, itemIdentifier) -> UICollectionViewListCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration<HomeHeaderView>(
            elementKind: UICollectionView.elementKindSectionHeader
        ) { _, _, _ in }
        dataSource.supplementaryViewProvider = { [weak self] collectionView, _, indexPath -> UICollectionReusableView? in
            return self?.collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        }
        
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
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let distanceAction = UIAlertAction(title: "By distance", style: .default) { [weak self] _ in
            self?.presenter.filterType = .distance
        }
        alert.addAction(distanceAction)
        
        let alphabeticalAction = UIAlertAction(title: "Alphabetical", style: .default) { [weak self] _ in
            self?.presenter.filterType = .alphabetical
        }
        alert.addAction(alphabeticalAction)
        
        let calncelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(calncelAction)
        
        present(alert, animated: true)
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
        snapshot.appendItems(presenter.filteredServers.map { $0.id })
        
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
