//
//  ListTableView.swift
//  DevExam
//
//  Created by Vlad Ralovich on 8.03.22.
//

import UIKit

class ListTableView: UITableView {
    
    var cells: [ListModel] = []
    
    init() {
        super.init(frame: .zero, style: .plain)
        delegate = self
        dataSource = self
        allowsSelection = false
        register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = cells[indexPath.row].title
        return cell
    }
}