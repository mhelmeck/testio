import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: LoginPresenter!
    
    private let backgroundImageView = buildImageView(
        name: "background.pdf",
        contentMode: .scaleAspectFill
    )
    
    private let logoImageView = buildImageView(
        name: "logo.pdf",
        contentMode: .scaleAspectFit
    )
    
    private let usernameTextField = buildTextField(
        placeholder: "Username",
        iconName: "person.circle",
        isSecureTextEntry: false
    )
    
    private let passwordTextField = buildTextField(
        placeholder: "Password",
        iconName: "lock.circle",
        isSecureTextEntry: true
    )
    
    private let loginButton = buildButton()
    
    private let activityIndicator = buildActivityIndicatorView()
    
    // MARK: - Init
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        print("my_log init LoginViewController")
    }
    
    deinit {
        print("my_log deinit LoginViewController")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        installConstraints()
        setDelegatesAndTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Methods
    
    private func setupView() {
        view.backgroundColor = .white
        
        [
            backgroundImageView,
            logoImageView,
            usernameTextField,
            passwordTextField,
            loginButton,
            activityIndicator
        ].forEach(view.addSubview)
    }
    
    private func installConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80.0),
            
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32.0),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32.0),
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 40.0),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40.0),
            
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32.0),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32.0),
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 16.0),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40.0),
            
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40.0),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40.0),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40.0),
            loginButton.heightAnchor.constraint(equalToConstant: 40.0),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setDelegatesAndTargets() {
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        usernameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if textField == usernameTextField {
            presenter.username = textField.text ?? String()
        } else if textField == passwordTextField {
            presenter.password = textField.text ?? String()
        }
    }
    
    @objc private func login() {
        presenter.login()
    }
}

// MARK: - LoginView

extension LoginViewController: LoginView {
    func showLoading() {
        view.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        view.isUserInteractionEnabled = true
        activityIndicator.stopAnimating()
    }
    
    func enableLoginButton() {
        loginButton.isEnabled = true
    }
    
    func disableLoginButton() {
        loginButton.isEnabled = false
    }
    
    func showLoginFailure(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
  
        present(alert, animated: true)
    }
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.leftView!.tintColor = .textFieldTextColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, text.isEmpty {
            textField.leftView!.tintColor = .textFieldPlaceholderColor
        }
    }
}
