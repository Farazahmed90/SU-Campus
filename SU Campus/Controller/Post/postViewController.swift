//
//  postViewController.swift
//  SU Campus

//  Copyright © 2019 www.d-tech.com. All rights reserved.
//

import UIKit

class postViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate , UIScrollViewDelegate
{
    let dataConnection = Data()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var detailTextField: UITextView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        roundTextField(textfield: detailTextField)
        roundButton(button: postButton)
        
        scrollView.isScrollEnabled = false
        
        detailTextField.text = "Post"
        detailTextField.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
     
        self.hideKeyboardWhenTappedAround()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        scrollView.isScrollEnabled = true
    }
 
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        scrollView.setContentOffset(.zero, animated: true)
        scrollView.isScrollEnabled = false
    }
    
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if (textView.text == "Post" && textView.textColor == #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        {
            textView.text = ""
            textView.textColor = .black
        }
        textView.becomeFirstResponder() //Optional
        scrollView.isScrollEnabled = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView)
    {
        if (textView.text == "")
        {
            textView.text = "Post"
            textView.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
        textView.resignFirstResponder()
        
        scrollView.setContentOffset(.zero, animated: true)
        scrollView.isScrollEnabled = false
    }

    @IBAction func postButton_Clicked(_ sender: Any)
    {
        var postCategory:String!
        let user = dataConnection.getCurrentUser().split(separator: "@")
        user[1] == "admin.com" ? (postCategory = "News") : (postCategory = "Post")
        dataConnection.post(detailTextField: detailTextField, PostCategory: postCategory, completion: { message in
            message == "Posted Succesfully" ? self.makeAlert(message: message, clearTextBox: true) : self.makeAlert(message: message, clearTextBox: false)
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    //MARK:- To make UIAlert
    func makeAlert(message: String , clearTextBox: Bool)
    {
        let alert = UIAlertController(title: "SU Campus", message: "\(message)", preferredStyle: .alert)
        let restartaction = UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            if clearTextBox{
                self.detailTextField.text = nil
            }
        })
        alert.addAction(restartaction)
        present(alert, animated: true, completion: nil)
    }
    
 
    //MARK:- To Make Button Round
    func roundButton(button: UIButton)
    {
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
    }
    
    //MARK:- To Make TextView Round
    func roundTextField(textfield:UITextView)
    {
        detailTextField.clipsToBounds = true
        detailTextField.layer.cornerRadius = 10.0
        self.detailTextField.layer.borderWidth = 1.0
        detailTextField.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    

}

