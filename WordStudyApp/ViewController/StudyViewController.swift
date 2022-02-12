//
//  StudyViewController.swift
//  WordStudyApp
//
//  Created by yasudamasato on 2021/07/21.
//

import UIKit
import RealmSwift

final class StudyViewController: UIViewController {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var meaningLabel: UILabel!
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var meaningButton: UIButton!
    private var array = WordArray.array
    private var tapCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBarbackgroundColor(.systemTeal)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        array.nameArray = RealmClient.shared.getTextObjects()
        array.meaningArray = RealmClient.shared.getMeaningObjects()
        nameLabel.text = array.nameArray.first
        meaningLabel.text = ""
        tapCount = 0
    }

    @IBAction func didTapFloat(_ sender: Any) {
        configureFloating()
    }

    @IBAction func pressNextButton(_ sender: Any) {
        guard !array.nameArray.isEmpty else { return }
        tapCount += 1
        if tapCount == array.nameArray.count {
            tapCount = 0
            nameLabel.text = array.nameArray.first
        } else {
            nameLabel.text = array.nameArray[tapCount]
        }
        meaningLabel.text = ""
    }

    @IBAction func pressMeaningButton(_ sender: Any) {
        guard var meaningIndex: Int = array.meaningArray.indices.first else { return }
        meaningIndex = tapCount
        meaningLabel.text = array.meaningArray[meaningIndex]
    }
}
