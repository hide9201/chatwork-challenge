//
//  UIScrollView+.swift
//  chatwork-challenge
//
//  Created by hide on 2023/11/07.
//

import UIKit

extension UIScrollView {
    
    func scrollToBottom(animated: Bool) {
        if self.contentSize.height < self.bounds.size.height { return }
        let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height)
        self.setContentOffset(bottomOffset, animated: animated)
    }
    
    func scrollVertically(by height: CGFloat, animated: Bool) {
        let offset = CGPoint(x: 0, y: self.contentOffset.y + height)
        self.setContentOffset(offset, animated: animated)
    }
}
