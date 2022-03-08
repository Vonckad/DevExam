//
//  MainModels.swift
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

enum Main
{
  // MARK: Use cases
  
  enum Something
  {
    struct Request
    {
        enum RequestType {
            case getList
        }
    }
    struct Response
    {
        enum ResponseType {
            case presentList(_ : [ListModel])
            case presentAlert(_ : String)
        }
    }
    struct ViewModel
    {
        enum viewModelData {
            case list(_ : [ListModel])
            case showAlert(_ : String)
        }
    }
  }
}
