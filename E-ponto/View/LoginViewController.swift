//
//  LoginViewController.swift
//  E-ponto
//
//  Created by Denis Nascimento on 31/05/17.
//  Copyright (c) 2017 Denis Nascimento. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class LoginViewController: BaseViewController {
    
    private var viewModel: LoginViewModel!
    private let disposeBag = DisposeBag()
    
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var requestButton: UIButton!
    @IBOutlet weak var signingUpOulet: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
        setupModelView()
        
        viewModel.signingIn
            .debug("signingIn")
            .drive(signingUpOulet.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.loginEnabled
            .drive(onNext: { [weak self] valid  in
                self?.loginButton.isEnabled = valid
                self?.loginButton.alpha = valid ? 1.0 : 0.5
            })
            .disposed(by: disposeBag)
        
        viewModel.signedIn
            .debug("signedIn")
            .drive(onNext: { [weak self] user in
                if (user != nil) {
                    self?.loginSuccessful()
                    self?.goMainView()
                } else {
                    self?.loginFailure()
                }
            })
        .disposed(by: disposeBag)
        
    }
    
    func loginFailure() -> Void {
        showMessage(title: nil, message: "Não foi possível logar com os dados informados!", button: "OK")
    }
    
    func loginSuccessful() -> Void {
        showMessage(title: nil, message: "Login efetuado com sucesso", button: "OK")
    }
    
    func goMainView() -> Void {
        
        let navController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navController") as! UINavigationController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = navController
        
        
    }
    
    // MARK: - setup
    
    func setupLayout() {
        
        usernameTextField.addBottomBorderWithColor(color: UIColor.gray, width: 1.0)
        passwordTextField.addBottomBorderWithColor(color: UIColor.gray, width: 1.0)
        usernameTextField.text = "fdenisnascimento@gmail.com"
        passwordTextField.text = "123456"
    }
    
    private func setupModelView() {
        self.viewModel = LoginViewModel(input:
            (username: usernameTextField.rx.text.orEmpty.asDriver(),
             password: passwordTextField.rx.text.orEmpty.asDriver(),
             loginTap:self.loginButton.rx.tap.asDriver()
        ))
    }
    
    
}
