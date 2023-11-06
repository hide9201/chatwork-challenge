//
//  ChatRoomViewController.swift
//  chatwork-challenge
//
//  Created by hide on 2023/11/06.
//

import UIKit
import ReusableKit
import Combine
import CombineCocoa

final class ChatRoomViewController: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var messageTableView: UITableView! {
        didSet {
            messageTableView.dataSource = self
            messageTableView.register(MessageTableViewCell.reusable)
        }
    }

    @IBOutlet weak var sendMessageStackView: UIStackView!
    @IBOutlet weak var messageBodyTextView: UITextView!
    @IBOutlet weak var sendMessageStackViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var sendMessageStackViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var sendButton: UIButton!
    
    // MARK: - Property
    
    private var chatRoomViewModel: ChatRoomViewModel!
    
    private let didLoad: PassthroughSubject<Void, Never> = .init()
    private let sendButtonDidTap: PassthroughSubject<String, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        navigationItem.title = chatRoomViewModel.room.name
        sendMessageStackView.addBorder(width: 1.0, color: UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0), position: .top)
        
        sendButton.tapPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let self = self,
                      let body = self.messageBodyTextView.text
                else { return }
                self.sendButtonDidTap.send(body)
                self.messageBodyTextView.text = ""
                self.messageBodyTextView.resignFirstResponder()
            }
            .store(in: &cancellables)
        
        chatRoomViewModel.bind(input: .init(viewDidLoad: didLoad.eraseToAnyPublisher(),
                                            textEdited: messageBodyTextView.textPublisher.compactMap { $0 }.eraseToAnyPublisher(),
                                            sendButtonDidTap: sendButtonDidTap.eraseToAnyPublisher()))
        
        didLoad.send()
        
        chatRoomViewModel.messages
            .receive(on: DispatchQueue.main)
            .sink { [weak self] messages in
                UIView.animate(withDuration: 0.0) {
                    self?.messageTableView.reloadData()
                } completion: { _ in
                    // reloadData()完了後に行う処理，scrollToBottomが初回ロードの時だけ何故かズレてしまう
                    self?.messageTableView.scrollToBottom(animated: true)
                }
            }
            .store(in: &cancellables)
        
        chatRoomViewModel.isTextEmpty
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isTextEmpty in
                self?.sendButton.isEnabled = !isTextEmpty
            }
            .store(in: &cancellables)
        
        messageTableView.willBeginDraggingPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.messageBodyTextView.resignFirstResponder()
            }
            .store(in: &cancellables)
        
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .compactMap { $0.userInfo }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] userInfo in
                guard let self = self,
                      let keyboardHeight = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height,
                      let keyboardAnimationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
                      let keyboardAnimationCurve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
                else { return }
                
                UIView.animate(withDuration: keyboardAnimationDuration, delay: 0, options: UIView.AnimationOptions(rawValue: keyboardAnimationCurve)) {
                    self.sendMessageStackViewBottomConstraint.constant = keyboardHeight
                    
                    // ここはviewModelの仕事?
                    let bottomOffset = CGPoint(x: 0, y: self.messageTableView.contentOffset.y + keyboardHeight)
                    
                    self.messageTableView.setContentOffset(bottomOffset, animated: false)
                    self.messageTableView.layoutIfNeeded()
                }
            }
            .store(in: &cancellables)
        
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .compactMap { $0.userInfo }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] userInfo in
                guard let self = self,
                      let keyboardAnimationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
                      let keyboardAnimationCurve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
                else { return }
                
                UIView.animate(withDuration: keyboardAnimationDuration, delay: 0, options: UIView.AnimationOptions(rawValue: keyboardAnimationCurve)) {
                    self.sendMessageStackViewBottomConstraint.constant = 0
                }
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
        let cell = messageTableView.dequeue(MessageTableViewCell.reusable, for: indexPath)
        cell.inject(chatRoomViewModel.messages.value[indexPath.row])
        return cell
    }
}
