//
//  ExtensionView.swift
//  HotelsApp
//
//  Created by Roman Lantsov on 08.09.2023.
//

import Foundation
import UIKit

extension UIView {
    func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            self.addSubview(subview)
        }
    }
}
