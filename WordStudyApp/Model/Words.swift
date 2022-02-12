//
//  Words.swift
//  WordStudyApp
//
//  Created by yasudamasato on 2021/07/21.
//

import Foundation
import RealmSwift

final class Words: Object {
    @objc dynamic var text = ""
    @objc dynamic var meaning = ""
}

final class WordArray {
    static let array = WordArray()
    private init() {}

    var nameArray = [String]()
    var meaningArray = [String]()
}
