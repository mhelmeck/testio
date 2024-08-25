protocol LoginView: AnyObject {
    func showLoading()
    func hideLoading()
    func enableLoginButton()
    func disableLoginButton()
    func showLoginFailure(title: String, message: String)
}
