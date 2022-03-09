//
//  ListTableView.swift
//  DevExam
//
//  Created by Vlad Ralovich on 8.03.22.
//

import UIKit

protocol ListTableViewDelegate {
    func selectCell(indexPath: IndexPath)
}

class ListTableView: UITableView {
    
    var cells: [ListModel] = []
    var listDelegate: ListTableViewDelegate?
    
    init() {
        super.init(frame: .zero, style: .plain)
        delegate = self
        dataSource = self
        register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
        separatorStyle = .none
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 600
        backgroundColor = UIColor(red: 238/255, green: 235/255, blue: 248/255, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ListTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseIdentifier, for: indexPath) as! ListTableViewCell
        let data = cells[indexPath.row]
        cell.addData(title: data.title, detail: data.text, date: data.date, urlImage: data.image)
        return cell
    }
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? ListTableViewCell { cell.cancelDownloadTask() }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listDelegate?.selectCell(indexPath: indexPath)
    }
}
