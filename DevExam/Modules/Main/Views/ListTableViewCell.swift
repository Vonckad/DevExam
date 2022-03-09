//
//  ListTableViewCell.swift
//  DevExam
//
//  Created by Vlad Ralovich on 8.03.22.
//

import UIKit
import Kingfisher

class ListTableViewCell: UITableViewCell {

    static let reuseIdentifier = "list-cell-reuse-identifier"
    let view = UIView()
    let myImageView = UIImageView()
    let titleLabel = UILabel()
    let detailLabel = UILabel()
    let dateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func addData(title: String, detail: String , date: String, urlImage: String) {
        titleLabel.text = title
        detailLabel.text = detail
        dateLabel.text = date
        loadImage(urlImage)
    }
    
    func cancelDownloadTask() {
        myImageView.kf.cancelDownloadTask()
    }
    
    private func loadImage(_ url: String){
        guard let urlImage = URL(string: "http://dev-exam.l-tech.ru\(url)") else { return }
//        print("http://dev-exam.l-tech.ru\(url)")
        myImageView.kf.indicatorType = .activity
        myImageView.kf.setImage(with: urlImage, options: [.transition(.fade(0.3))])
    }

}

extension ListTableViewCell {
    private func configure() {
        backgroundColor = .clear
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.clipsToBounds = true
        
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(view)
        view.addSubview(myImageView)
        view.addSubview(titleLabel)
        view.addSubview(detailLabel)
        view.addSubview(dateLabel)

        titleLabel.numberOfLines = 0
        titleLabel.sizeToFit()
        titleLabel.textColor = .black
        
        detailLabel.numberOfLines = 0
        detailLabel.sizeToFit()
        detailLabel.textColor = .black
        
        dateLabel.textColor = .black
        
        let spacing = CGFloat(8)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: spacing / 2),
            view.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: spacing),
            view.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -spacing),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -spacing / 2),
            
            myImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: spacing),
//            myImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            myImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: spacing),

            myImageView.widthAnchor.constraint(equalToConstant: 64),
            myImageView.heightAnchor.constraint(equalToConstant: 64),

            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: spacing),
            titleLabel.leftAnchor.constraint(equalTo: myImageView.rightAnchor, constant: spacing),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -spacing),

            detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: spacing),
            detailLabel.leftAnchor.constraint(equalTo: myImageView.rightAnchor, constant: spacing),
            detailLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -spacing),
            
            dateLabel.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: spacing),
            dateLabel.leftAnchor.constraint(equalTo: myImageView.rightAnchor, constant: spacing),
            dateLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -spacing),
            dateLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -spacing),
            ])
    }
}
