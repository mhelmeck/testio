protocol Storage {
    func write<T: Encodable>(_ item: T, forKey key: String)
    func read<T: Decodable>(forKey key: String) -> T?
    func delete(forKey key: String)
}
