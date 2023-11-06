//
//  NibInstantiatable.swift
//  chatwork-challenge
//
//  Created by hide on 2023/11/07.
//

import UIKit
import Instantiate

typealias NibInstantiatable = Instantiate.NibInstantiatable

extension NibInstantiatable where Self: UIView {
    public static var nibName: NibName {
        return className
    }
}

extension NibInstantiatable where Self: UIViewController {
    public static var nibName: NibName {
        return className
    }
}
