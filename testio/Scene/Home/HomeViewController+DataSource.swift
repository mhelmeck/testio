import UIKit

extension HomeViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Server.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Server.ID>
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: Server.ID) {
        let server = presenter.server(withId: id)
        
        var contentConfiguration = cell.homeCellConfiguration()
        contentConfiguration.server = server.name
        contentConfiguration.distance = server.distance
        
        cell.contentConfiguration = contentConfiguration
    }
    
    func supplementaryRegistrationHandler(progressView: HomeHeaderView, elementKind: String, indexPath: IndexPath) {
        headerView = progressView
    }
}
