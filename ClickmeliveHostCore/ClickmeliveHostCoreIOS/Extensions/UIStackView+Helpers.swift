//
//  UIStackView+Helpers.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 5.05.2022.
//

import UIKit

extension UIStackView {
    func addArrangedSubview(_ v: UIView, withMargin m: UIEdgeInsets) {
        let containerForMargin = UIView()
        containerForMargin.addSubview(v)
        v.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            v.topAnchor.constraint(equalTo: containerForMargin.topAnchor, constant:m.top ),
            v.bottomAnchor.constraint(equalTo: containerForMargin.bottomAnchor, constant: m.bottom ),
            v.leftAnchor.constraint(equalTo: containerForMargin.leftAnchor, constant: m.left),
            v.rightAnchor.constraint(equalTo: containerForMargin.rightAnchor, constant: m.right)
        ])

        addArrangedSubview(containerForMargin)
    }
}
