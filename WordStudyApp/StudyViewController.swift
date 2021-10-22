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
    private var nameIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        nextButton.layer.borderWidth = 3.0
        meaningButton.layer.borderWidth = 3.0
        nextButton.layer.borderColor = UIColor {_ in return #colorLiteral(red: 0.9489346147, green: 0.9319375753, blue: 0.702398777, alpha: 1)}.cgColor
        meaningButton.layer.borderColor = UIColor {_ in return #colorLiteral(red: 0.9489346147, green: 0.9319375753, blue: 0.702398777, alpha: 1)}.cgColor

        utilityDataSet()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        utilityDataSet()
        nameIndex = tapCount
    }

    private func utilityDataSet() {
        array.nameArr = realm.objects(Words.self).value(forKey: "name") as! [String]
        array.meaningArr = realm.objects(Words.self).value(forKey: "meaning") as! [String]

        nameLabel.text = array.nameArr.first
        meaningLabel.text = ""

        tapCount = 0
    }

    private func configureView() {
        setStatusBarbackgroundColor(.systemTeal)
    }

    @IBAction func didTapFloat(_ sender: Any) {
        configureFloating()
    }

    @IBAction func pressNextButton(_ sender: Any) {

        guard array.nameArr.isEmpty == false else {
            return
        }

        tapCount += 1
        nameIndex = tapCount

        if nameIndex == array.nameArr.count {
            tapCount = 0
            nameLabel.text = array.nameArr.first
        }else {
            nameLabel.text = array.nameArr[nameIndex!]
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
