//
//  ViewController.swift
//  Message ProtoType

//  Copyright © 2019 d-tech. All rights reserved.
//

import UIKit

class messageViewController: UIViewController , UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate
{
    let dataConnection = Data()
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var messagestableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    var messages = [
                     MessageData(sender: "a.moid", text: "lk hasd oash d oiuah", isFirstUser: true),
                     MessageData(sender: "aqib", text: "aksajd oisnnodi asd", isFirstUser: false),
                     MessageData(sender: "wasiq", text: "fasgsag", isFirstUser: false),
                     MessageData(sender: "faraz", text: "asdasdasd", isFirstUser: false),
                     MessageData(sender: "a.moid", text: "a ksnda suod huasda", isFirstUser: true)
                   ]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector (tableViewTapped))
        messagestableView.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func tableViewTapped() {
        closeKeyBoard()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MessageTableViewCell
        cell.updateMessageView(by: messages[indexPath.row])
        return cell
    }
    
    @IBAction func sendButtonClicked(_ sender: Any)
    {
        print("Send is clicked")
        if messageTextField.text != ""
        {
            let userName = dataConnection.getCurrentUser().split(separator: "@")
            messages.append(MessageData(sender: String(userName[0]), text: messageTextField.text!, isFirstUser: true))
            self.messagestableView.reloadData()
        }else{
            makeAlert(message: "Enter some Text")
        }
        self.messageTextField.text = nil
        closeKeyBoard()
    }
    
    func closeKeyBoard()
    {
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 50
            self.view.layoutIfNeeded()
            self.messageTextField.endEditing(true)
        }
    }
    
    //MARK: - TextField Delegate Methods
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 308
            self.view.layoutIfNeeded()
        }
    }
    
    //MARK: - TextField Delegate Methods
    func makeAlert(message: String)
    {
        let alert = UIAlertController(title: "SU Campus", message: "\(message)", preferredStyle: .alert)
        let restartaction = UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
        })
        alert.addAction(restartaction)
        present(alert, animated: true, completion: nil)
    }
}




