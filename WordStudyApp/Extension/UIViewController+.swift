//
//  StatusBar.swift
//  WordStudyApp
//
//  Created by yasudamasato on 2021/10/16.
//

import UIKit
import SwiftUI

extension UIViewController {
    private final class StatusBarView: UIView {}

    func setStatusBarbackgroundColor(_ color: UIColor?) {
        for subView in self.view.subviews where subView is StatusBarView {
            subView.removeFromSuperview()
        }
        guard let color = color else {
            return
        }
        let statusBarView = StatusBarView()
        statusBarView.backgroundColor = color
        self.view.addSubview(statusBarView)
        statusBarView.translatesAutoresizingMaskIntoConstraints = false
        statusBarView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        statusBarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        statusBarView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        statusBarView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
    }

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
