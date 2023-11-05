//
//  ChatRoomViewController.swift
//  chatwork-challenge
//
//  Created by hide on 2023/11/06.
//

import UIKit
import Combine
import CombineCocoa

final class ChatRoomViewController: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var messageTableView: UITableView! {
        didSet {
            messageTableView.dataSource = self
        }
    }
    
    @IBOutlet weak var sendButton: UIButton!
    
    // MARK: - Property
    
    private var chatRoomViewModel: ChatRoomViewModel!
    
    private let didLoad: PassthroughSubject<Void, Never> = .init()
    private let sendButtonDidTap: PassthroughSubject<String, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        navigationItem.title = chatRoomViewModel.room.name
        
        sendButton.tapPublisher
            .sink { [weak self] in
                self?.sendButtonDidTap.send("textViewの内容")
            }
            .store(in: &cancellables)
        
        chatRoomViewModel.bind(input: .init(viewDidLoad: didLoad.eraseToAnyPublisher(), sendButtonDidTap: sendButtonDidTap.eraseToAnyPublisher()))
        
        didLoad.send()
        
        chatRoomViewModel.messages
            .sink { [weak self] message in
                self?.messageTableView.reloadData()
            }
            .store(in: &cancellables)
    }
}

extension ChatRoomViewController: Storyboardable {
    
    func inject(_ dependency: Room) {
        chatRoomViewModel = ChatRoomViewModel(room: dependency)
    }
}

extension ChatRoomViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(chatRoomViewModel.messages.value.count)
        return chatRoomViewModel.messages.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = chatRoomViewModel.messages.value[indexPath.row].body
        
        return cell
    }
}
