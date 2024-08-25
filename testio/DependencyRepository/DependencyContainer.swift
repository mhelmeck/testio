class DependencyContainer: DependencyRepository {
    
    // MARK: - Properties
    
    private var dependencies: [String: Any] = [:]
    
    // MARK: - Api
    
    func register<T>(dependency: T, for type: T.Type) {
        let key = String(describing: type)
        dependencies[key] = dependency
    }
    
    func get<T>(_ dependency: T.Type) -> T {
        let key = String(describing: dependency)
        return dependencies[key] as! T
    }
}
