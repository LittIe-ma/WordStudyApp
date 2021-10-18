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
            print("privacyPolicy")
        }
        let aboutApp = UIAction(title: "このアプリについて") { (action) in
            print("about this app")
        }

        let menu = UIMenu(title: "", children: [privacyPolicy, aboutApp])
        let menuBarItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis")?.withTintColor(.white, renderingMode: .alwaysOriginal), menu: menu)
        navigationItem.rightBarButtonItem = menuBarItem
    }
}
