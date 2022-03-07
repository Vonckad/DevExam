//
//  SingInPresenter.swift
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

protocol SingInPresentationLogic
{
  func presentSomething(response: SingIn.Something.Response)
}

class SingInPresenter: SingInPresentationLogic
{
  weak var viewController: SingInDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: SingIn.Something.Response)
  {
    let viewModel = SingIn.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}