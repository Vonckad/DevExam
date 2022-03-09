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
    let myImageView = UIImageView()
    let titleLabel = UILabel()
    let detailLabel = UILabel()
    let dateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
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
        myImageView.kf.setImage(with: urlImage)
    }

}

extension ListTableViewCell {
    private func configure() {
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(myImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailLabel)
        contentView.addSubview(dateLabel)

        titleLabel.numberOfLines = 0
        titleLabel.sizeToFit()
        
        detailLabel.numberOfLines = 0
        detailLabel.sizeToFit()
        
//        myImageView.layer.borderColor = UIColor.black.cgColor
//        myImageView.layer.borderWidth = 1
//        myImageView.layer.cornerRadius = 4
        myImageView.backgroundColor = UIColor.systemBlue
        
        let spacing = CGFloat(8)
        NSLayoutConstraint.activate([
            myImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: spacing),
//            myImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            myImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: spacing),

            myImageView.widthAnchor.constraint(equalToConstant: 64),
            myImageView.heightAnchor.constraint(equalToConstant: 64),

            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: spacing),
            titleLabel.leftAnchor.constraint(equalTo: myImageView.rightAnchor, constant: spacing),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -spacing),

            detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: spacing),
            detailLabel.leftAnchor.constraint(equalTo: myImageView.rightAnchor, constant: spacing),
            detailLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -spacing),
            
            dateLabel.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: spacing),
            dateLabel.leftAnchor.constraint(equalTo: myImageView.rightAnchor, constant: spacing),
            dateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -spacing),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -spacing),
            ])
    }
}
