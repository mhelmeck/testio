import Foundation

protocol Network {
    func getData<T: Decodable>(with request: URLRequest) async throws -> T
}
