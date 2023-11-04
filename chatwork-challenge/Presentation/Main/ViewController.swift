//
//  ViewController.swift
//  chatwork-challenge
//
//  Created by hide on 2023/11/02.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var tokenTextField: UITextField!
    
    // MARK: - Property
    
    private var cancellables: [AnyCancellable] = []
    private var myAccountService = MyAccountService()
    private var roomService = RoomService()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Action
    
    @IBAction func loginButtonDidTap(_ sender: Any) {
        guard let token = tokenTextField.text else { return }
        AppConstant.token = token
        
        roomService.getRoomList()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: { rooms in
                print(rooms)
            })
            .store(in: &cancellables)
    }
}

