protocol HomeView: AnyObject {
    func showLoading()
    func hideLoading()
    func showNetworkFailure(title: String, message: String)
}
