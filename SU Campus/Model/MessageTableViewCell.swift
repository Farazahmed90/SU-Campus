//
//  MessageTableViewCell.swift
//  Message ProtoType

//  Copyright © 2019 d-tech. All rights reserved.
//

import UIKit

struct MessageData
{
    let sender:String
    let text:String
    let isFirstUser:Bool
}

class MessageTableViewCell: UITableViewCell
{
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageBackgroundView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var nametrailingConstraint: NSLayoutConstraint!
    var nameleadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    var leadingConstraint: NSLayoutConstraint!
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        messageLabel.text = nil
        nameLabel.text = nil
        
        leadingConstraint.isActive = false
        trailingConstraint.isActive = false
        
        nametrailingConstraint.isActive = false
        nameleadingConstraint.isActive = false
    }
    
    func updateMessageView(by message: MessageData)
    {
        messageBackgroundView.layer.cornerRadius = 16
        messageBackgroundView.clipsToBounds = true
        trailingConstraint = messageBackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        leadingConstraint = messageBackgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        
        nametrailingConstraint = nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25)
        nameleadingConstraint = nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25)
  
        messageLabel.text = message.text
        nameLabel.text = message.sender

        if message.isFirstUser{
            messageBackgroundView.backgroundColor = UIColor(red: 53/255.0, green: 150/255.0, blue: 255/255.0, alpha: 1)
            trailingConstraint.isActive = true
            nametrailingConstraint.isActive = true
            messageLabel.textAlignment = .right
            nameLabel.textAlignment = .right

        }else{
            messageBackgroundView.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            leadingConstraint.isActive = true
            nameleadingConstraint.isActive = true
            messageLabel.textAlignment = .left
            nameLabel.textAlignment = .left
        }
    }
}
