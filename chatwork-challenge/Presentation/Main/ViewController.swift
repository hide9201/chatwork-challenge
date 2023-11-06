//
//  ViewController.swift
//  chatwork-challenge
//
//  Created by hide on 2023/11/02.
//

import UIKit
import Combine
import CombineCocoa

final class ViewController: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var tokenTextField: UITextField!
    
    // MARK: - Property
    
    private let viewModel = ViewModel()
    private let loginButtonDidTap: PassthroughSubject<String, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.tapPublisher
            .sink { [weak self] in
                self?.errorMessageLabel.text = ""
                self?.loginButtonDidTap.send(self?.tokenTextField.text ?? "")
            }
            .store(in: &cancellables)
        viewModel.bind(input: .init(loginButtonDidTap: loginButtonDidTap.eraseToAnyPublisher()))
        
        viewModel.errorLabelText
            .sink { [weak self] errorLabelText in
                self?.errorMessageLabel.text = errorLabelText
            }
            .store(in: &cancellables)
        
        viewModel.rooms
            .receive(on: DispatchQueue.main)
            .sink { [weak self] rooms in
                if rooms.isEmpty { return }
                let roomListViewController = RoomListViewController(with: rooms)
                self?.navigationController?.pushViewController(roomListViewController, animated: true)
            }
            .store(in: &cancellables)
    }
}

