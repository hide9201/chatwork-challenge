//
//  NSObject+.swift
//  chatwork-challenge
//
//  Created by hide on 2023/11/02.
//

import Foundation

extension NSObject {
    
    static var className: String {
        return String(describing: self)
    }
    
    var className: String {
        return type(of: self).className
    }
}
