//
//  indexViewController.swift
//  SU Campus
//

//  Copyright © 2019 www.d-tech.com. All rights reserved.
//

import UIKit

class indexViewController: UIViewController, UITextFieldDelegate
{
    let dataConnection = Data()
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        roundButton(button: loginButton)
        roundButton(button: signupButton)
        roundTextField(textfield: emailTextField)
        roundTextField(textfield: passwordTextField)
        emailTextField.keyboardType = .emailAddress
        self.hideKeyboardWhenTappedAround()
        CheckInternet.Connection() ? print("Connected To Internet") : (makeAlert(message: "You are not connected to internet", clearTextBox: false))
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        transparentNavBar(color: .white)
        navigationController?.navigationBar.barStyle = .black
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
    }
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        login()
        return true
    }
    
    @IBAction func loginButton_Clicked(_ sender: Any)
    {
       login()
    }
    
    func login()
    {
        if emailTextField.text != "" && passwordTextField.text != ""
        {
            dataConnection.SignIn(emailTextField: emailTextField , passwordTextField: passwordTextField , completion:
                { message in
                    message == "Done" ? (self.performSegue(withIdentifier: "goToIndexFromLogin", sender: self)) : self.makeAlert(message: "\(message)", clearTextBox: false)
            })
        }
        else
        {
            makeAlert(message: "No Data is provided", clearTextBox: false)
        }
    }
    
    @IBAction func signupButton_Clicked(_ sender: Any)
    {
        performSegue(withIdentifier: "goToSignUP", sender: self)
    }
    
    //MARK:- To Make Button Round
    
    func roundButton(button: UIButton)
    {
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
    }
    
    //MARK:- To Make TextField Round
    
    func roundTextField(textfield:UITextField)
    {
        textfield.borderStyle = UITextField.BorderStyle.roundedRect
    }

    //MARK:- To Make Alert

    func makeAlert(message: String , clearTextBox: Bool)
    {
        let alert = UIAlertController(title: "SU Campus", message: "\(message)", preferredStyle: .alert)
        let restartaction = UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            if clearTextBox{
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
            }
        })
        alert.addAction(restartaction)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK:- To Make NavigationBar Transparent
    func transparentNavBar(color: UIColor)
    {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = color
    }
}

extension UIViewController
{
    //MARK:- To make the keyboard close on tap
    func hideKeyboardWhenTappedAround()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
        
    }
}

   


