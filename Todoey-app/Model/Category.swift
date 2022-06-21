//
//  Category.swift
//  Todoey-app
//
//  Created by Stacy on 20.06.22.
//

import Foundation
import RealmSwift
import CyaneaOctopus


class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    let items = List<Item>()
}
