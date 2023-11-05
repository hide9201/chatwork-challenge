//
//  RoomListViewController.swift
//  chatwork-challenge
//
//  Created by hide on 2023/11/05.
//

import UIKit
import Combine
import CombineCocoa

final class RoomListViewController: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var roomListTableView: UITableView!
    
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
