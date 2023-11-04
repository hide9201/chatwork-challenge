//
//  ViewModel.swift
//  chatwork-challenge
//
//  Created by hide on 2023/11/04.
//

import Foundation
import Combine

struct ViewModelInput {

    let loginButtonDidTap: AnyPublisher<String, Never>
}

final class ViewModel {
    
    // MARK: - Property
    
    private var cancellables = Set<AnyCancellable>()
    private let myAccountService = MyAccountService()
    private let roomService = RoomService()
    
    var rooms = CurrentValueSubject<[Room], Never>([])
    var errorLabelText = CurrentValueSubject<String, Never>("")
    var roomListView = AnyPublisher<[Room], Never>([].publisher)
    
    func bind(input: ViewModelInput) {
        input.loginButtonDidTap
            .sink { [weak self] token in
                self?.getRoomList(token: token)
            }
            .store(in: &cancellables)
    }
    
    func getRoomList(token: String) {
        roomService.getRoomList(token: token)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    self.rooms.value = []
                    self.errorLabelText.value = "ログインに失敗しました"
                    print(error)
                }
            }, receiveValue: { rooms in
                self.rooms.value = rooms
                self.errorLabelText.value = ""
                print(rooms)
            })
            .store(in: &cancellables)
    }
}
