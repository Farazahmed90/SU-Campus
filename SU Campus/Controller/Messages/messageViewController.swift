//
//  ViewController.swift
//  Message ProtoType
//
//  Created by Abdul Moid on 09/09/2019.
//  Copyright © 2019 d-tech. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate,UITableViewDataSource
{
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messagestableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    var messages = [
                     MessageData(sender: "abdul moid", text: "lk hasd oash d oiuah", isFirstUser: true),
                     MessageData(sender: "aqib naeem", text: "aksajd oisnnodi asd", isFirstUser: false),
                     MessageData(sender: "wasiq hussain", text: "fasgsag", isFirstUser: false),
                     MessageData(sender: "faraz ahemd", text: "asdasdasd", isFirstUser: false),
                     MessageData(sender: "abdul moid", text: "a ksnda suod huasda", isFirstUser: true)
                   ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messagestableView.dataSource = self
        messagestableView.delegate = self
        messageTextField.borderStyle = UITextField.BorderStyle.roundedRect
        
        sendButton.layer.cornerRadius = 15
        sendButton.clipsToBounds = true
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MessageTableViewCell
        cell.updateMessageView(by: messages[indexPath.row])
        return cell
    }
}


