//
//  Extension.swift
//  WordStudyApp
//
//  Created by Masato Yasuda on 2022/02/12.
//

import UIKit

extension UIView {
    @IBInspectable
    var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
}
