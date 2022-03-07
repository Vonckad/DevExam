//
//  SingInInteractor.swift
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

protocol SingInBusinessLogic
{
  func doSomething(request: SingIn.Something.Request)
}

protocol SingInDataStore
{
  //var name: String { get set }
}

class SingInInteractor: SingInBusinessLogic, SingInDataStore
{
  var presenter: SingInPresentationLogic?
  var worker: SingInWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: SingIn.Something.Request)
  {
    worker = SingInWorker()
    worker?.doSomeWork()
    
    let response = SingIn.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
