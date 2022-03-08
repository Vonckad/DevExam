//
//  SingInViewController.swift
//  DevExam
//
//  Created by Vlad Ralovich on 7.03.22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SingInDisplayLogic: AnyObject
{
    func displaySomething(viewModel: SingIn.Something.ViewModel.viewModelData)
}

class SingInViewController: UIViewController, SingInDisplayLogic
{
  var interactor: SingInBusinessLogic?
  var router: (NSObjectProtocol & SingInRoutingLogic & SingInDataPassing)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = SingInInteractor()
    let presenter = SingInPresenter()
    let router = SingInRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    doSomething()
    setupUI()
    view.backgroundColor = UIColor(red: 238/255, green: 235/255, blue: 248/255, alpha: 1)
  }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginTextField.layer.cornerRadius = 8
        passwordTextField.layer.cornerRadius = 8
    }
  
  // MARK: Do something
  
    private let logoImageView = UIImageView(image: UIImage(named: "logo"))
    private let loginTextField = UITextField()
    private let passwordTextField = UITextField()
    private let singInButton = UIButton()
    
    private func setupUI() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        singInButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(logoImageView)
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
        view.addSubview(singInButton)
        let guide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 16),
            logoImageView.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            
            loginTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 32),
            loginTextField.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: 16),
            loginTextField.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -16),
            
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 16),
            passwordTextField.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: 16),
            passwordTextField.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -16),
            
            singInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 32),
            singInButton.widthAnchor.constraint(equalToConstant: 100),
            singInButton.centerXAnchor.constraint(equalTo: guide.centerXAnchor)
        ])
        
        loginTextField.keyboardType = .numberPad
        loginTextField.delegate = self
        loginTextField.backgroundColor = .white
        loginTextField.textColor = .black
        loginTextField.attributedPlaceholder = .init(string: " ", attributes: [.foregroundColor : UIColor.systemGray, .font : UIFont.systemFont(ofSize: 24)])

        passwordTextField.backgroundColor = .white
        passwordTextField.attributedPlaceholder = .init(string: "Password", attributes: [.foregroundColor : UIColor.systemGray, .font : UIFont.systemFont(ofSize: 24)])
        passwordTextField.textColor = .black
        passwordTextField.isSecureTextEntry = true
        
        singInButton.backgroundColor = .brown
        singInButton.setTitle("Sign In", for: .normal)
        singInButton.titleLabel?.attributedText = .init(string: "Sign In", attributes: [
            .foregroundColor : UIColor(red: 238/255, green: 235/255, blue: 248/255, alpha: 1),
            .font : UIFont.systemFont(ofSize: 24)])
        singInButton.layer.cornerRadius = 8
        singInButton.addTarget(self, action: #selector(singIn), for: .touchUpInside)
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing)))
    }
  @objc
    func singIn() {
        loginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
  func doSomething()
  {
      interactor?.doSomething(request: .getPhoneMask)
  }
  
    func displaySomething(viewModel: SingIn.Something.ViewModel.viewModelData)
  {
      
      switch viewModel {
      case .currentPhoneMask(let phoneMask):
          loginTextField.placeholder = phoneMask
      case .formatedPhoneMask(let number):
          loginTextField.text = number
      }
  }
}

extension SingInViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        interactor?.doSomething(request: .getFormattedPhoneNumber(newString))
        return false
    }
}
