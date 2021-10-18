//
//  SetWordViewController.swift
//  WordStudyApp
//
//  Created by yasudamasato on 2021/07/21.
//

import UIKit
import RealmSwift

class WordArray {
    var nameArr = [String]()
    var meaningArr = [String]()

    static let arr = WordArray()

    private init() {}
}

class SetWordViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPopoverPresentationControllerDelegate {

    @IBOutlet private weak var wordField: UITextField!
    @IBOutlet private weak var meaningField: UITextField!
    @IBOutlet private weak var tableView: UITableView!
    private var alertController: UIAlertController!
    private var realm = try! Realm()
    private var array = WordArray.arr
    var wordArray: Results<Words>!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        
        tableView.dataSource = self
        tableView.delegate = self

        wordArray = realm.objects(Words.self)

        array.nameArr = realm.objects(Words.self).value(forKey: "name") as! [String]
        array.meaningArr = realm.objects(Words.self).value(forKey: "meaning") as! [String]
    }

    private func configureView() {
        setStatusBarbackgroundColor(.systemTeal)
    }

    func alert(title: String, message: String) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

    @IBAction func didTapFloat(_ sender: Any) {
        configureFloating()
    }

    @IBAction func addButton(_ sender: Any) {
        let words = Words()
        print(Realm.Configuration.defaultConfiguration.fileURL!)

        guard wordField.text != "" else {
            alert(title: "単語を入力してください", message: "")
            return
        }
        guard meaningField.text != "" else {
            alert(title: "意味を入力してください", message: "")
            return
        }

        words.name = wordField.text!
        words.meaning = meaningField.text!

        try! realm.write {
            realm.add(words)
        }

        wordField.text = ""
        meaningField.text = ""
        array.nameArr = [wordField.text!]
        array.meaningArr = [meaningField.text!]

        tableView.reloadData()
    }

    @IBAction func deleteAllButton(_ sender: Any) {

        let actionSheet = UIAlertController(title: "項目を全て削除", message: "本当によろしいですか？", preferredStyle: .actionSheet)

        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) -> Void in
            try! realm.write {
                realm.deleteAll()
            }
            array.nameArr.removeAll()
            array.meaningArr.removeAll()

            tableView.reloadData()
        })

        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)

        actionSheet.addAction(defaultAction)
        actionSheet.addAction(cancelAction)

        present(actionSheet, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            try! realm.write {
                realm.delete(self.wordArray[indexPath.row])
            }
            array.nameArr.remove(at: indexPath.row)
            array.meaningArr.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        realm.objects(Words.self).count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordCell", for: indexPath)

        let item: Words = self.wordArray[indexPath.row]

        cell.textLabel?.text = item.name

        return cell
    }

}
