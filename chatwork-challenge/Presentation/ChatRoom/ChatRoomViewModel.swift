//
//  ChatRoomViewModel.swift
//  chatwork-challenge
//
//  Created by hide on 2023/11/06.
//

import Foundation
import Combine

struct ChatRoomViewModelInput {
    
    let viewDidLoad: AnyPublisher<Void, Never>
    let textEdited: AnyPublisher<String, Never>
    let sendButtonDidTap: AnyPublisher<String, Never>
}

final class ChatRoomViewModel {
    
    // MARK: - Property
    
    var room: Room
    var messages = CurrentValueSubject<[Message], Never>([])
    var isTextEmpty = CurrentValueSubject<Bool, Never>(true)
    
    private var cancellables = Set<AnyCancellable>()
    private let roomService = RoomService()
    
    // MARK: - Initializer
    
    init(room: Room) {
        self.room = room
    }
    
    func bind(input: ChatRoomViewModelInput) {
        input.viewDidLoad
            .sink { [weak self] in
                self?.getMessages()
            }
            .store(in: &cancellables)
        
        input.textEdited
            .sink { [weak self] text in
                guard let self = self else { return }
                self.isTextEmpty.value = self.isEmpty(text: text)
            }
            .store(in: &cancellables)
        
        input.sendButtonDidTap
            .sink { [weak self] body in
                // 送信処理
                self?.postMessage(body: body)
            }
            .store(in: &cancellables)
    }
    
    func getMessages() {
        roomService.getMessages(roomId: room.roomId)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: { messages in
                self.messages.value = messages
            })
            .store(in: &cancellables)
    }
    
    func postMessage(body: String) {
        roomService.postMessage(roomId: room.roomId, body: body)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: { [weak self] _ in
                self?.getMessages()
            })
            .store(in: &cancellables)
    }
    
    func isEmpty(text: String) -> Bool {
        return text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
