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
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var meaningButton: UIButton!
    private var realm = try! Realm()
    private var array = WordArray.arr
    private var tapCount = 0
    private var textIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        setStatusBarbackgroundColor(.systemTeal)
        utilityDataSet()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        utilityDataSet()
        textIndex = tapCount
    }

    private func utilityDataSet() {
        array.nameArr = realm.objects(Words.self).value(forKey: "text") as! [String]
        array.meaningArr = realm.objects(Words.self).value(forKey: "meaning") as! [String]

        nameLabel.text = array.nameArr.first
        meaningLabel.text = ""

        tapCount = 0
    }

    @IBAction func didTapFloat(_ sender: Any) {
        configureFloating()
    }

    @IBAction func pressNextButton(_ sender: Any) {

        guard array.nameArr.isEmpty == false else {
            return
        }

        tapCount += 1
        textIndex = tapCount

        if textIndex == array.nameArr.count {
            tapCount = 0
            nameLabel.text = array.nameArr.first
        }else {
            nameLabel.text = array.nameArr[textIndex!]
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
