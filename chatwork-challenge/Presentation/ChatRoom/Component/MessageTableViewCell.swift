//
//  MessageTableViewCell.swift
//  chatwork-challenge
//
//  Created by hide on 2023/11/07.
//

import UIKit
import ReusableKit

final class MessageTableViewCell: UITableViewCell {
    
    static let reusable = ReusableCell<MessageTableViewCell>(nibName: "MessageTableViewCell")
    
    @IBOutlet weak var accountAvatarImageView: UIImageView!
    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var sendTimeLabel: UILabel!
}

extension MessageTableViewCell: NibInstantiatable {
    func inject(_ dependency: Message) {
        accountAvatarImageView.load(dependency.account.avatarImageUrl, processorOption: .circle)
        accountNameLabel.text = dependency.account.name
        bodyLabel.text = dependency.body
        
        let timeInterval = Double(dependency.sendTime)
        let date = Date(timeIntervalSince1970: timeInterval)
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "ja_JP")
        sendTimeLabel.text = formatter.string(from: date)
    }
}
