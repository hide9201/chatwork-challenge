//
//  Storyboardable.swift
//  chatwork-challenge
//
//  Created by hide on 2023/11/02.
//

import UIKit
import Instantiate

typealias Storyboardable = StoryboardInstantiatable

extension Storyboardable where Self: UIViewController {
    static var storyboardName: StoryboardName {
        return className.replacingOccurrences(of: "ViewController", with: "")
    }
}
