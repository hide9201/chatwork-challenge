//
//  RoomListViewController.swift
//  chatwork-challenge
//
//  Created by hide on 2023/11/05.
//

import UIKit
import Combine

final class RoomListViewController: UIViewController {
    
    // MARK: - Property
    
    private var rooms: [Room]!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        print(rooms!)
    }
}

extension RoomListViewController: Storyboardable {
    
    func inject(_ dependency: [Room]) {
        rooms = dependency
    }
}
