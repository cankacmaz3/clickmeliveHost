//
//  CMLTextField.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 21.04.2022.
//

import UIKit

// MARK: - ClickMeLive Text Field
open class CMLTextField: UITextField {
    
    private enum Constants {
        static let borderWidth: CGFloat = 1.0
        static let borderColor: CGColor = UIColor.rgb(red: 221, green: 226, blue: 229).cgColor
        static let placeholderColor: UIColor = Colors.primaryPlaceholderText
    }
    
    let padding: CGFloat
    
    public init(padding: CGFloat,
                font: UIFont,
                cornerRadius: CGFloat = 0.0,
                keyboardType: UIKeyboardType = .default,
                backgroundColor: UIColor = .clear,
                isSecureTextEntry: Bool = false,
                placeholder: String = "",
                placeholderFont: UIFont = UIFont.systemFont(ofSize: 16),
                centered: Bool = false,
                withBorder: Bool = true) {
        
        self.padding = padding
        super.init(frame: .zero)
        
        self.font = font
        self.backgroundColor = backgroundColor
        self.keyboardType = keyboardType
        self.isSecureTextEntry = isSecureTextEntry
        self.layer.cornerRadius = cornerRadius
        self.autocorrectionType = .no
        
        if withBorder {
            self.layer.borderWidth = Constants.borderWidth
            self.layer.borderColor = Constants.borderColor
        }
        
        if centered {
            self.setupCenteredPlaceholder(placeholder: placeholder, font: placeholderFont)
            self.textAlignment = .center
        } else {
            self.setupPlaceholder(placeholder: placeholder, font: placeholderFont)
        }
        
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCenteredPlaceholder(placeholder: String, font: UIFont) {
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        self.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.paragraphStyle: centeredParagraphStyle,
                         NSAttributedString.Key.foregroundColor: Constants.placeholderColor,
                         NSAttributedString.Key.font: font]
        )
    }
    
    func setupPlaceholder(placeholder: String, font: UIFont) {
        self.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: Constants.placeholderColor,
                         NSAttributedString.Key.font: font]
        )
    }
}

