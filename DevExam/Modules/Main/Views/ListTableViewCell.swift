//
//  ListTableViewCell.swift
//  DevExam
//
//  Created by Vlad Ralovich on 8.03.22.
//

import UIKit

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
    
    func addData(title: String, detail: String , date: String) {
        titleLabel.text = title
        detailLabel.text = detail
        dateLabel.text = date
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

        titleLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.numberOfLines = 0
        
        detailLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        detailLabel.adjustsFontForContentSizeCategory = true
        detailLabel.numberOfLines = 0

        myImageView.layer.borderColor = UIColor.black.cgColor
        myImageView.layer.borderWidth = 1
        myImageView.layer.cornerRadius = 4
        myImageView.backgroundColor = UIColor.systemBlue
        
        let spacing = CGFloat(8)
        NSLayoutConstraint.activate([
            myImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: spacing),
//            myImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: spacing),
            myImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: spacing),
            myImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -spacing),
            myImageView.widthAnchor.constraint(equalToConstant: 64),

            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: spacing),
            titleLabel.leftAnchor.constraint(equalTo: myImageView.leftAnchor, constant: spacing),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: spacing),

            detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: spacing),
            detailLabel.leftAnchor.constraint(equalTo: myImageView.leftAnchor, constant: spacing),
            detailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: spacing),
            detailLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: spacing)
            ])
    }
}
