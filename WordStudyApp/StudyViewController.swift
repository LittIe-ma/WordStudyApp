//
//  StudyViewController.swift
//  WordStudyApp
//
//  Created by yasudamasato on 2021/07/21.
//

import UIKit
import RealmSwift

class StudyViewController: UIViewController {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var meaningLabel: UILabel!
    private var realm = try! Realm()
    private var array = WordArray.arr
    private var tapCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()

        array.nameArr = realm.objects(Words.self).value(forKey: "name") as! [String]
        array.meaningArr = realm.objects(Words.self).value(forKey: "meaning") as! [String]

        nameLabel.text = array.nameArr.first

        tapCount = 0
    }

    private func configureView() {
        setStatusBarbackgroundColor(.systemTeal)
    }

    @IBAction func pressNextButton(_ sender: Any) {
        guard var nameIndex: Int = array.nameArr.indices.first else {
            return
        }

        tapCount += 1
        nameIndex = tapCount

        if nameIndex == array.nameArr.count {
            tapCount = 0
            nameLabel.text = array.nameArr.first
        }else {
            nameLabel.text = array.nameArr[nameIndex]
        }

        meaningLabel.text = ""
    }

    @IBAction func pressMeaningButton(_ sender: Any) {
        guard var meaningIndex: Int = array.meaningArr.indices.first else {
            return
        }

        meaningIndex = tapCount

        meaningLabel.text = array.meaningArr[meaningIndex]
    }
}
