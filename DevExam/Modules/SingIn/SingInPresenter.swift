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
    func presentSomething(response: SingIn.Something.Response.ResponseType)
}

class SingInPresenter: SingInPresentationLogic
{
  weak var viewController: SingInDisplayLogic?
  
  // MARK: Do something
  
    func presentSomething(response: SingIn.Something.Response.ResponseType)
  {
      switch response {
      case .pesentPhoneMask(let phoneMask):
          viewController?.displaySomething(viewModel: .currentPhoneMask(phoneMask.phoneMask))
      case .formatPhomeMask(phoneMask: let mask, number: let number):
          formatPhoneNumber(phoneMask: mask, number: number) //может вынести это в interactor?
      case .presenrtUser(mask: let mask, username: let username, password: let password):
          viewController?.displaySomething(viewModel: .currentUser(username: formatPhoneNumber(phoneMask: mask, number: username), password: password))
      case .presentMainVC:
          viewController?.displaySomething(viewModel: .pushMainVC)
      }
  }
    
   private func formatPhoneNumber(phoneMask: PhoneMaskModel, number: String) -> String {
        
        let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()

        var mask = "+X (XXX) XXX-XXXX"

        if phoneMask.phoneMask.contains("3") {
            mask = "+XXX XX-XXX-XXXX"
        } else if phoneMask.phoneMask.contains("7") {
            if phoneMask.phoneMask.contains("(") {
                mask = "+X (XXX) XXX-XX-XX"
            } else {
                mask = "+X XXX XXX-XX-XX"
            }
        } else if phoneMask.phoneMask.contains("4") {
            mask = "+XX XXXX-XXXXXX"
        }

        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask where index < cleanPhoneNumber.endIndex {
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        viewController?.displaySomething(viewModel: .formatedPhoneMask(result))
       return result
    }
}


