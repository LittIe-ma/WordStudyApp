//
//  StudyViewController.swift
//  WordStudyApp
//
//  Created by yasudamasato on 2021/07/21.
//

import UIKit

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

    @IBAction func didTapFloat(_ sender: UIButton) {
        configureFloating()
    }

    @IBAction func didTapNextButton(_ sender: UIButton) {
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

    @IBAction func didTapBackButton(_ sender: UIButton) {
        guard !array.nameArray.isEmpty, tapCount != 0 else { return }
        tapCount -= 1
        nameLabel.text = array.nameArray[tapCount]
        meaningLabel.text = ""
    }

    @IBAction func didTapMeaningButton(_ sender: UIButton) {
        guard !array.meaningArray.isEmpty else { return }
        meaningLabel.text = array.meaningArray[tapCount]
    }
}
