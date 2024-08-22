protocol AuthService {
    func login(with credentials: Credentials) async throws
    func logout()
    func isLoggedIn() -> Bool
}
