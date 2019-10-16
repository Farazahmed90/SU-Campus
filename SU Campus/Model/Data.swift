//
//  Data.swift
//  Traffik Now
//
//  Created by Abdul Moid on 4/1/1398 AP.
//  Copyright © 1398 www.d-tech.com. All rights reserved.
//

import Foundation
import Firebase
import SVProgressHUD

struct post_array
{
    var sender = String()
    var location_body = String()
    var details_body = String()
    var date = String()
    var id = String()
}

class Data
{
    var isLogedin = false
    var postArray = [[post_array]]()
    let defaults = UserDefaults.standard

    func retrieve_post(postcategory: String,completion: @escaping (_ message: String) -> Void)
    {
        SVProgressHUD.show()
        _ = Database.database().reference().child(postcategory).observe(.value){ (snapshot) in self.postArray.removeAll()
            for child in snapshot.children
            {
                let firebaseDB = child as! DataSnapshot
                let snapshotVaule = firebaseDB.value as! [String: Any]
                
                self.postArray.insert([post_array(sender: snapshotVaule["Sender"]! as! String, location_body: snapshotVaule["location"]! as! String , details_body: snapshotVaule["Postbody"]! as! String , date : snapshotVaule["Date"]! as! String, id: "\(firebaseDB.key)")] , at: 0)
            }
            completion("Done")
            SVProgressHUD.dismiss()
        }
    }
    
    func SignIn(emailTextField:UITextField ,passwordTextField: UITextField, completion: @escaping (_ message: String) -> Void)
    {
        SVProgressHUD.show()
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!)
        { (user, error) in
            SVProgressHUD.dismiss()
            if error != nil
            {
                completion(self.checkError(error: error!))
            }
            else
            {
                self.isLogedin = true
                print(self.isLogedin)
                self.defaults.set(self.isLogedin , forKey: "checkSignIn")
                completion("Done")
            }
        }
    }
    
    func deletePost(category:String ,child: String , completion: @escaping (_ message: String) -> Void)
    {
        let ref = Database.database().reference().child("\(category)").child("\(child)")
        ref.removeValue { error, _ in
            if error != nil
            {
                print(error as Any)
                completion("Error Deleting Post")
            }
            else
            {
                print("Deleted")
                completion("Done")
            }
        }
    }
    
    func getCurrentUser() -> String
    {
        return (Auth.auth().currentUser?.email)!
    }
    
    func SignUp(emailTextField:UITextField ,passwordTextField: UITextField, completion: @escaping (_ message: String) -> Void)
    {
        SVProgressHUD.show()
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil
            {
                SVProgressHUD.dismiss()
                completion(self.checkError(error: error!))
            }
            else
            {
                completion("Done")
                SVProgressHUD.dismiss()
                print("Registration Succesful")
            }
        }
    }
    
    func signOut(completion: @escaping (_ message: String) -> Void)
    {
        SVProgressHUD.show()
        do
        {
            try Auth.auth().signOut()
            SVProgressHUD.dismiss()
            isLogedin = false
            self.defaults.set(self.isLogedin , forKey: "checkSignIn")
            completion("Done")
        }
        catch let error as NSError
        {
            print (error.localizedDescription)
        }
    }
    
    func post(detailTextField:UITextView, completion: @escaping (_ message: String) -> Void)
    {
        if detailTextField.text != ""
        {
            SVProgressHUD.show()

            let formatter = DateFormatter()
            
            formatter.dateStyle = .short
            formatter.timeStyle = .short
            
            let date = formatter.string(from: Date())
            let username = Auth.auth().currentUser?.email
            let user = username!.split(separator: "@")
            
            let messageDB = Database.database().reference().child("Post")
            let postDictionary = ["Sender":
                "\(user[0])" ,"location":"Karachi, PK","Postbody":
                    detailTextField.text!,"Date" : date]
            messageDB.childByAutoId().setValue(postDictionary) { (Error, DatabaseReference) in
                if Error != nil{
                    completion("Error Posting")
                }
                else{
                    print("Post Added")
                    completion("Posted Succesfully")
                }
                SVProgressHUD.dismiss()
            }
        }
        else{
            completion("Fill All TextFields")
        }
    }
    
    func checkError(error:Error) -> String
    {
        let errCode = AuthErrorCode(rawValue: error._code)
        switch errCode {
        case .emailAlreadyInUse?:
            return "Email Already in Use"
        case .weakPassword?:
            return "Pasword doesnot meant the requirment"
        case .invalidEmail?:
            return "Email is not Valid"
        case .wrongPassword?:
            return "Wrong Password"
        default:
            print("Create User Error: \(error)")
            return "Error"
        }
    }
}
