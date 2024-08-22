protocol Storage {
    func readSession() -> UserSession?
}

class UserDefaultStorage: Storage {
    func readSession() -> UserSession? {
        return nil
    }
}
