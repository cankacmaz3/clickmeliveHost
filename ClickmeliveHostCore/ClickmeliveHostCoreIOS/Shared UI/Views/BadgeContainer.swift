//
//  BadgeContainer.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import UIKit

public protocol BadgeContainer: AnyObject {
    var badgeView: UIView? { get set }
    var badgeLabel: UILabel? { get set }
    func showBadge(blink: Bool, text: String?, badgeColor: UIColor)
    func hideBadge()
}

extension BadgeContainer where Self: UIView {
    public func showBadge(blink: Bool, text: String?, badgeColor: UIColor = .red) {
        if badgeView != nil {
            if badgeView?.isHidden == false {
                return
            }
        } else {
            badgeView = UIView()
        }

        badgeView?.backgroundColor = badgeColor
        guard let badgeViewUnwrapped = badgeView else {
            return
        }
        //adds the badge at the top
        addSubview(badgeViewUnwrapped)
        badgeViewUnwrapped.translatesAutoresizingMaskIntoConstraints = false

        var size = CGFloat(6)
        if let textUnwrapped = text {
            if badgeLabel == nil {
                badgeLabel = UILabel()
            }
            
            guard let labelUnwrapped = badgeLabel else {
                return
            }
            
            labelUnwrapped.text = textUnwrapped
            labelUnwrapped.textColor = .white
            labelUnwrapped.font = .systemFont(ofSize: 12)
            labelUnwrapped.translatesAutoresizingMaskIntoConstraints = false

            badgeViewUnwrapped.addSubview(labelUnwrapped)
            let labelConstrainst = [labelUnwrapped.centerXAnchor.constraint(equalTo: badgeViewUnwrapped.centerXAnchor),                                    labelUnwrapped.centerYAnchor.constraint(equalTo: badgeViewUnwrapped.centerYAnchor)]
            NSLayoutConstraint.activate(labelConstrainst)
            
            size = CGFloat(12 + 2 * textUnwrapped.count)
        }
        
        let sizeConstraints = [badgeViewUnwrapped.widthAnchor.constraint(equalToConstant: size), badgeViewUnwrapped.heightAnchor.constraint(equalToConstant: size)]
        NSLayoutConstraint.activate(sizeConstraints)
        
        badgeViewUnwrapped.layer.cornerRadius = size / 2
        
        let position = [badgeViewUnwrapped.topAnchor.constraint(equalTo: self.topAnchor, constant: -size / 2),
        badgeViewUnwrapped.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: size/2)]
        NSLayoutConstraint.activate(position)
        
        if blink {
            let animation = CABasicAnimation(keyPath: "opacity")
            animation.duration = 1.2
            animation.repeatCount = .infinity
            animation.fromValue = 0
            animation.toValue = 1
            animation.timingFunction = .init(name: .easeOut)
            badgeViewUnwrapped.layer.add(animation, forKey: "badgeBlinkAnimation")
        }
    }
    
    public func hideBadge() {
        badgeView?.layer.removeAnimation(forKey: "badgeBlinkAnimation")
        badgeView?.removeFromSuperview()
        badgeView = nil
        badgeLabel = nil
    }
}
