//
//  RealmClient.swift
//  WordStudyApp
//
//  Created by Masato Yasuda on 2022/02/12.
//

import RealmSwift

final class RealmClient {
    static let shared = RealmClient()
    private init() {}

    private let realm = try! Realm()

    func numberOfItems() -> Int {
        realm.objects(Words.self).count
    }

    func getObjects() -> Results<Words> {
        realm.objects(Words.self)
    }

    func getTextObjects() -> [String] {
        realm.objects(Words.self).value(forKey: "text") as! [String]
    }

    func getMeaningObjects() -> [String] {
        realm.objects(Words.self).value(forKey: "meaning") as! [String]
    }

    func add(_ Words: Words) {
        try! realm.write { realm.add(Words) }
    }

    func delete(_ Words: Words) {
        try! realm.write { realm.delete(Words) }
    }

    func deleteAll() {
        try! realm.write { realm.deleteAll() }
    }

    func update(index: Int, text: String) {
        let Words: Results<Words> = realm.objects(Words.self)
        try! realm.write { Words[index].text = text }
    }
}
