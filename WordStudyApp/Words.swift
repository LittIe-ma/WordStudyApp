//
//  Words.swift
//  WordStudyApp
//
//  Created by yasudamasato on 2021/07/21.
//

import Foundation
import RealmSwift

class Words: Object {
    @objc dynamic var text = ""
    @objc dynamic var meaning = ""
}

