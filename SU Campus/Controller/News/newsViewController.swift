//
//  newsViewController.swift
//  SU Campus
//
//  Copyright © 2019 www.d-tech.com. All rights reserved.
//

import UIKit

class newsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource
{    
    let dataConnection = Data()
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.clear
        setLongTap()
        CheckInternet.Connection() ? print("Connected To Internet") : (makeAlert(message: "You are not connected to internet"))
    }
        
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        loadData()
    }
    
    @objc func longPress(_ longPressGestureRecognizer: UILongPressGestureRecognizer)
    {
        if dataConnection.defaults.bool(forKey: "checkSignIn") == true
        {
            if longPressGestureRecognizer.state == UIGestureRecognizer.State.began
            {
                let touchPoint = longPressGestureRecognizer.location(in: self.tableView)
                if let indexPath = tableView.indexPathForRow(at: touchPoint)
                {
                    tableView.deselectRow(at: indexPath, animated: true)
                    let user = dataConnection.getCurrentUser().split(separator: "@")
                    if user[1] == "admin.com"
                    {
                        deletePost(id: dataConnection.postArray[indexPath.section][indexPath.row].id)
                    }
                }
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return dataConnection.postArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        var result = String()
        section == 0 ? (result = "") : (result = " ")
        return result
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dataConnection.postArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! newsTableViewCell
        
        cell.layer.cornerRadius = 10            //To make cell edges round
        cell.layer.masksToBounds = true
        
        cell.emailLabel.text = "@SSUET"
        cell.detailsLabel.text = dataConnection.postArray[indexPath.section][indexPath.row].details_body
        cell.detailsLabel.numberOfLines = 0
        cell.locationLabel.text = dataConnection.postArray[indexPath.section][indexPath.row].location_body
        cell.locationLabel.numberOfLines = 0
        cell.locationLabel.textColor = UIColor.gray
        cell.dateLabel.textColor = UIColor.gray
        cell.dateLabel.text = dataConnection.postArray[indexPath.section][indexPath.row].date
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let returnedView = UIView()
        returnedView.backgroundColor = UIColor.clear    //To make tableView header transparent
        return returnedView
    }
    
    //MARK:- To Make Alert
    
    func makeAlert(message: String)
    {
        let alert = UIAlertController(title: "SU Campus", message: "\(message)", preferredStyle: .alert)
        let restartaction = UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
        })
        alert.addAction(restartaction)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK:- To load data in tableView
    func loadData()
    {
        dataConnection.retrieve_post(postcategory: "News", completion:
            { message in
                if  message == "Done"
                {
                    self.tableView.reloadData()
                }
                else
                {
                    self.makeAlert(message: "Error Loding Data")
                }
                
        })
    }
    
    //MARK:- To deletePost
    func deletePost(id: String)
    {
        let alert = UIAlertController(title: "SU Campus", message: "Are you sure you want to delete post?", preferredStyle: .alert)
        let restartaction = UIAlertAction(title: "Delete", style: .destructive, handler: { (UIAlertAction) in
            
            self.dataConnection.deletePost(category: "News" , child: "\(id)" , completion:
                { message in
                    message == "Done" ? self.loadData() : self.makeAlert(message: "\(message)")
            })
        })
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { (UIAlertAction) in
        })
        alert.addAction(cancel)
        alert.addAction(restartaction)
        present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    //MARK:- To set the long tap on TableView
    func setLongTap()
    {
        let longPressGesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(newsViewController.longPress(_:)))
        longPressGesture.minimumPressDuration = 1.0 // 1 second press
        longPressGesture.delegate = self as? UIGestureRecognizerDelegate
        self.tableView.addGestureRecognizer(longPressGesture)
    }
}




