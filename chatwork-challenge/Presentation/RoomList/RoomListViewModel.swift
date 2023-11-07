//
//  RoomListViewModel.swift
//  chatwork-challenge
//
//  Created by hide on 2023/11/05.
//

import Foundation

final class RoomListViewModel {
    
    // MARK: - Property
    
    var rooms: [Room]
    
    // MARK: - Initializer
    
    init(rooms: [Room]) {
        self.rooms = rooms
    }
}
