//
//  SetWordViewController.swift
//  WordStudyApp
//
//  Created by yasudamasato on 2021/07/21.
//

import UIKit
import RealmSwift

final class SetWordViewController: UIViewController {

    @IBOutlet private weak var wordField: UITextField!
    @IBOutlet private weak var meaningField: UITextField!
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }
    }
    private var alertController: UIAlertController!
    private var array = WordArray.array
    var wordArray: Results<Words>!

    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        setStatusBarbackgroundColor(.systemTeal)
        wordArray = RealmClient.shared.getObjects()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        array.nameArray = RealmClient.shared.getTextObjects()
        array.meaningArray = RealmClient.shared.getMeaningObjects()
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
        guard let wordText = wordField.text, !wordText.isEmpty else { return }
        guard let meaningText = meaningField.text, !meaningText.isEmpty else { return }

        words.text = wordText
        words.meaning = meaningText

        RealmClient.shared.add(words)

        array.nameArray += [wordText]
        array.meaningArray += [meaningText]
        wordField.text = ""
        meaningField.text = ""

        tableView.reloadData()
    }

    @IBAction func deleteAllButton(_ sender: Any) {
        let actionSheet = UIAlertController(title: "項目を全て削除", message: "本当によろしいですか？", preferredStyle: .actionSheet)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) -> Void in
            RealmClient.shared.deleteAll()
            array.nameArray.removeAll()
            array.meaningArray.removeAll()
            tableView.reloadData()
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        actionSheet.addAction(defaultAction)
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true, completion: nil)
    }
}

extension SetWordViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        RealmClient.shared.numberOfItems()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item: Words = wordArray[indexPath.row]
        cell.textLabel?.text = item.text
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            RealmClient.shared.delete(wordArray[indexPath.row])
            array.nameArray.remove(at: indexPath.row)
            array.meaningArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
