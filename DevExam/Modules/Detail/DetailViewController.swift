//
//  DetailViewController.swift
//  DevExam
//
//  Created by Vlad Ralovich on 9.03.22.
//
// Я думаю, в рамках этой задачи, нет смысла создавать всю сцену clean swift для DetailViewController

import UIKit

class DetailViewController: UIViewController {

    var data: ListModel
    
    init(data: ListModel) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("detail data = \(data)")
        view.backgroundColor = .gray
    }
}
