//
//  DetailViewController.swift
//  DevExam
//
//  Created by Vlad Ralovich on 9.03.22.
//
// Я думаю, в рамках этой задачи, нет смысла создавать всю сцену clean swift для DetailViewController

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    var data: ListModel
    var titleLabel: UILabel!
    var descriptionLabel: UILabel!
    var imageView: UIImageView!
    
    init(data: ListModel) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 238/255, green: 235/255, blue: 248/255, alpha: 1)
        setupUI()
        addData()
    }
    
    private func addData() {
        guard let url = URL(string: "http://dev-exam.l-tech.ru\(data.image)") else { return }
        imageView.kf.setImage(with: url)
        title = data.title
        titleLabel.text = data.title
        descriptionLabel.text = data.text
    }
}

extension DetailViewController {
    private func setupUI() {
        imageView = UIImageView()
        titleLabel = UILabel()
        descriptionLabel = UILabel()
        
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .black
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textColor = .black
        
        imageView.contentMode = .scaleAspectFit
        descriptionLabel.numberOfLines = 0
        
        let guide = view.safeAreaLayoutGuide
        let spacing = CGFloat(16)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: guide.topAnchor, constant: spacing),
            imageView.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: spacing),
            imageView.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -spacing),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: spacing),
            titleLabel.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: spacing),
            titleLabel.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -spacing),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: spacing),
            descriptionLabel.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: spacing),
            descriptionLabel.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -spacing)
        ])
    }
}
