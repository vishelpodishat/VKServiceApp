//
//  UIView+Extension.swift
//  VKLinkApp
//
//  Created by Alisher Saideshov on 28.03.2024.
//

import UIKit

extension UIView {
    /// Description - Отключаю ТАМИК для обьектов во вью
    func addView(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
    }
}
