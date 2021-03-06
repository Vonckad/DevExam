//
//  MainInteractor.swift
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
import Alamofire

protocol MainBusinessLogic
{
    func doSomething(request: Main.Something.Request.RequestType)
}

protocol MainDataStore
{
    var list: [ListModel] { get set }
}

class MainInteractor: MainBusinessLogic, MainDataStore
{
  var presenter: MainPresentationLogic?
  var worker: MainWorker?
  var list: [ListModel] = []
  var sortBool = false
  
  // MARK: Do something
  
    func doSomething(request: Main.Something.Request.RequestType)
  {
    worker = MainWorker()
    worker?.doSomeWork()
      
      switch request {
      case .getList:
          timerRequest()
      case .sortList(byDate: let bool):
          sortBool = bool
          presenter?.presentSomething(response: .presentList(sortList(list: list, byDate: bool)))
      }
  }
    
    private func loadList(isLoad: @escaping (Bool)->()) {
        AF.request("http://dev-exam.l-tech.ru/api/v1/posts").validate()
            .responseDecodable(of: [ListModel].self) { response in
                switch response.result {
                case .success(let list):
                    self.list = list
                    self.presenter?.presentSomething(response: .presentList(self.sortList(list: list, byDate: self.sortBool)))
                    isLoad(true)
                case .failure(let error):
                    self.presenter?.presentSomething(response: .presentAlert("Error load list = \(error)"))
                    print("Error load list = \(error)")
                    isLoad(false)
                }
            }
    }
    
    private func sortList(list: [ListModel], byDate: Bool) -> [ListModel]{
        self.list = byDate ? list.sorted(by: {$0.date < $1.date}) : list.sorted(by: {$0.id < $1.id})
        return self.list
    }
    
    var myTimer = Timer.scheduledTimer(withTimeInterval: 20.0, repeats: false) { _ in
        print("timer.start 1")
    }
    
    private func timerRequest() {
        print("timerRequest")
        myTimer.invalidate()
        loadList { isLoad in
            print("isLoad")
            if isLoad {
                print("timer.start 2")
                self.myTimer = Timer.scheduledTimer(withTimeInterval: 20.0, repeats: false) { _ in
                    print("timer.finish 2")
                    self.timerRequest()
                }
            }
        }
    }
}
