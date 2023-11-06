//
//  BorderedTextView.swift
//  chatwork-challenge
//
//  Created by hide on 2023/11/06.
//

import UIKit

@IBDesignable final class BorderedTextView: UITextView {
    
    // MARK: - Property
    
    @IBInspectable var borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor {
        didSet {
            updateProperties()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 5.0 {
        didSet {
            updateProperties()
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 1.0 {
        didSet {
            updateProperties()
        }
    }
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateProperties()
    }
    
    // MARK: - Property
    
    private func updateProperties() {
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
    }
}
