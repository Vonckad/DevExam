//
//  ListModel.swift
//  DevExam
//
//  Created by Vlad Ralovich on 8.03.22.
//

import Foundation

struct ListModel: Decodable {
    var id: String
    var title: String
    var text: String
    var image: String
    var sort: Int
    var date: String
}
