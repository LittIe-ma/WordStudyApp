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
            let url = URL(string: "https://yasudam84.github.io/WordStudyApp/")!
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
        let aboutApp = UIAction(title: "このアプリについて") { (action) in
            
        }

        let menu = UIMenu(title: "", children: [privacyPolicy, aboutApp])
        let menuBarItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis")?.withTintColor(.white, renderingMode: .alwaysOriginal), menu: menu)
        navigationItem.rightBarButtonItem = menuBarItem
    }
}
