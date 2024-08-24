import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    let viewModel: LoginViewModel
    
    private let backgroundImageView = LoginViewController.buildImageView(
        name: "background.pdf",
        contentMode: .scaleAspectFill
    )
    
    private let logoImageView = LoginViewController.buildImageView(
        name: "logo.pdf",
        contentMode: .scaleAspectFit
    )
    
    private let usernameTextField = LoginViewController.buildTextField(
        placeholder: "Username",
        iconName: "person.circle",
        isSecureTextEntry: false
    )
    
    private let passwordTextField = LoginViewController.buildTextField(
        placeholder: "Password",
        iconName: "lock.circle",
        isSecureTextEntry: true
    )
    
    
//    private let loginButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("Log in", for: .normal)
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
//        button.backgroundColor = UIColor.systemBlue
//        button.tintColor = .white
//        button.layer.cornerRadius = 10
//        
//        return button
//    }()
    
    // MARK: - Init
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        
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
            logoImageView,
            usernameTextField,
            passwordTextField,
            backgroundImageView
//            loginButton
        ].forEach(view.addSubview)
    }
    
    private func installConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 40),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 16),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
//            
//            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
//            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
//            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
//            loginButton.heightAnchor.constraint(equalToConstant: 50)
            
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setDelegatesAndTargets() {
        usernameTextField.delegate = self
        passwordTextField.delegate = self
//        loginButton.addTarget(viewModel, action: #selector(viewModel.login), for: .touchUpInside)
    }
}

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
