protocol Storage {
    func writeToken(_ token: String)
    func readToken() -> String?
    func deleteToken()
}
