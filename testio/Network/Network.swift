import Foundation

protocol Network {
    func get<T: Decodable>(with request: URLRequest) async throws -> T
}
