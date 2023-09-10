//
//  UIlabel.swift
//  HotelsApp
//
//  Created by Roman Lantsov on 09.09.2023.
//

import UIKit

extension UILabel {
    convenience init(text: String, textColor: UIColor?, backgroundColor: UIColor, font: UIFont?, alignment: NSTextAlignment) {
        self.init()
        self.text = text
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.font = font
        self.textAlignment = alignment
        self.numberOfLines = 0
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
