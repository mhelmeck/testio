import UIKit

extension HomeViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Server.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Server.ID>
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: Server.ID) {
        let server = presenter.server(withId: id)
        
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = server.name
        contentConfiguration.secondaryText = String(server.distance)
        contentConfiguration.secondaryTextProperties.font = .preferredFont(forTextStyle: .caption1)
        cell.contentConfiguration = contentConfiguration
    }
}
