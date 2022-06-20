//
//  Category.swift
//  Todoey-app
//
//  Created by Stacy on 20.06.22.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
