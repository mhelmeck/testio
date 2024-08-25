protocol HomeView: AnyObject {
    func updateSnapshot()
    func showLoading()
    func hideLoading()
    func showNetworkFailure(title: String, message: String)
}
