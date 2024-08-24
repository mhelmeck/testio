protocol DependencyRepository {
    func register<T>(dependency: T, for type: T.Type)
    func get<T>(_ dependency: T.Type) -> T
}

extension DependencyRepository {
    func get<T>(_ dependency: T.Type = T.self) -> T {
        get(dependency)
    }
}
