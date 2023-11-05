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
    
    @IBOutlet weak var roomListTableView: UITableView! {
        didSet {
            roomListTableView.dataSource = self
        }
    }
    
    // MARK: - Property
    
    private var roomListViewModel: RoomListViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        navigationItem.hidesBackButton = true
        roomListTableView.didSelectRowPublisher
            .sink { [weak self] indexPath in
                guard let self = self else { return }
                
                let room = self.roomListViewModel.rooms[indexPath.row]
                let chatRoomViewController = ChatRoomViewController(with: room)
                self.navigationController?.pushViewController(chatRoomViewController, animated: true)
            }
            .store(in: &cancellables)
    }
}

// MARK: - Storyboardable

extension RoomListViewController: Storyboardable {
    
    func inject(_ dependency: [Room]) {
        roomListViewModel = RoomListViewModel(rooms: dependency)
    }
}

// MARK: - UITableViewDataSource

extension RoomListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomListViewModel.rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = roomListViewModel.rooms[indexPath.row].name
        return cell
    }
}
