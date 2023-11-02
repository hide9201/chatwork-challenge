//
//  ViewController.swift
//  chatwork-challenge
//
//  Created by hide on 2023/11/02.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var tokenTextField: UITextField!
    
    // MARK: - Property
    
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
            .done { rooms in
                print(rooms)
            }.catch { error in
                print(error)
            }
        
        myAccountService.getMyAccount()
            .done { myAccount in
                print(myAccount)
            }.catch { error in
                print(error)
            }
    }
}

