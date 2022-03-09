//
//  MainViewController.swift
//  DevExam
//
//  Created by Vlad Ralovich on 8.03.22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MainDisplayLogic: AnyObject
{
    func displaySomething(viewModel: Main.Something.ViewModel.viewModelData)
}

class MainViewController: UIViewController, MainDisplayLogic
{
  var interactor: MainBusinessLogic?
  var router: (NSObjectProtocol & MainRoutingLogic & MainDataPassing)?
  var tableView: ListTableView!
  var button: UIButton!
  var item: UIBarButtonItem!
    
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
    let interactor = MainInteractor()
    let presenter = MainPresenter()
    let router = MainRouter()
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
      
      view.backgroundColor = .white
      self.title = "DevExam"
      navigationItem.backButtonTitle = ""
      view.backgroundColor = UIColor(red: 238/255, green: 235/255, blue: 248/255, alpha: 1)
      
      button = UIButton()
      button.setImage(UIImage(named: "refresh"), for: .normal)
      button.imageView?.contentMode = .scaleAspectFit
      button.addTarget(self, action: #selector(refreshData), for: .touchUpInside)
      item = UIBarButtonItem(customView: button)
      
      navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.black, .font: UIFont.systemFont(ofSize: 24)]
      navigationController?.navigationBar.isOpaque = true
      navigationController?.navigationBar.tintColor = .gray
      self.navigationItem.rightBarButtonItem = item
      
      tableView = ListTableView()
      view.addSubview(tableView)
      tableView.frame = self.view.frame
      tableView.listDelegate = self
      
      doSomething()
  }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
  
  // MARK: Do something
  
  @objc
    func refreshData() {
        doSomething()
    }
  
  func doSomething()
  {
      interactor?.doSomething(request: .getList)
      stopActivity(false)
  }
  
    func displaySomething(viewModel: Main.Something.ViewModel.viewModelData)
  {
      switch viewModel {
      case .list(let list):
          tableView.cells = list
          tableView.reloadData()
          self.stopActivity(true)
      case .showAlert(let message):
          createAlert(message: message)
//      case .showDetailVC(let data):
//          router?.routeToDetailVC(indexPath: data)
      }
  }
    
    private func createAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            self.stopActivity(true)
            self.interactor?.doSomething(request: .getList)
            self.stopActivity(false)
        }))
        present(alert, animated: true)
    }
    
    private func stopActivity(_ bool: Bool) {

        tableView.alpha = bool ? 1.0 : 0.5
        tableView.allowsSelection = bool
        item.isEnabled = bool
        animateBarButton(bool)
    }
    
    private func animateBarButton(_ bool: Bool) {
        
        let refresh = self.navigationItem.rightBarButtonItem
        let layer = refresh?.customView?.layer
        let rotate = CABasicAnimation(keyPath: "transform.rotation.z")
           
        rotate.timingFunction = .init(name: .linear)
        rotate.fromValue = 0.0
        rotate.toValue = CGFloat(.pi * -2.0)
        rotate.duration = 1
        rotate.repeatCount = .greatestFiniteMagnitude
        
        if bool {
            layer?.removeAnimation(forKey: "transform.rotation.z")
        } else {
            layer?.add(rotate, forKey: "transform.rotation.z")
        }
    }
}

extension MainViewController: ListTableViewDelegate {
    func selectCell(indexPath: IndexPath) {
//        interactor?.doSomething(request: .presentDetailVC(indexPath: indexPath))
        router?.routeToDetailVC(indexPath: indexPath)
    }
}
