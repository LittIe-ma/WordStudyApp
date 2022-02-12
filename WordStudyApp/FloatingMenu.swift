//
//  FloatingMenu.swift
//  WordStudyApp
//
//  Created by yasudamasato on 2021/10/18.
//

import UIKit
import SwiftUI

extension UIViewController {

    func configureFloating() {
        let privacyPolicy = UIAction(title: "プライバシーポリシー") { (action) in
            guard let url = URL(string: "https://littie-ma.github.io/WordStudyApp/") else { return }
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
        let aboutApp = UIAction(title: "このアプリについて") { (action) in
            let dialog = UIAlertController(title: "シンプル単語カード", message: "隙間時間でも学習できるシンプルな\n単語暗記アプリです", preferredStyle: .alert)
            dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(dialog, animated: true, completion: nil)
        }
        let openSettings = UIAction(title: "ライセンス") { (action) in
            if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }

        let menu = UIMenu(title: "", children: [privacyPolicy, openSettings, aboutApp])
        let menuBarItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis")?.withTintColor(.white, renderingMode: .alwaysOriginal), menu: menu)
        navigationItem.rightBarButtonItem = menuBarItem
    }
}