//
//  moreTableViewController.swift
//  Traffik Now
//
//  Created by Abdul Moid on 12/06/2019.
//  Copyright © 2019 www.d-tech.com. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class moreTableViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let moreArray =
    [
        ["Name"],
        ["Sign Out"]
    ]
    
    let dataConnection = Data()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.clear
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return moreArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moreArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moreCell", for: indexPath)
       
        cell.layer.cornerRadius = 10            //To make cell edges round
        cell.layer.masksToBounds = true
        
        cell.textLabel?.textAlignment = .center
        moreArray[indexPath.section][indexPath.row] == "Name" ? (cell.textLabel?.text = dataConnection.getCurrentUser()) : (cell.textLabel?.text = moreArray[indexPath.section][indexPath.row])
        moreArray[indexPath.section][indexPath.row] == "Sign Out" ? (cell.textLabel?.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)) : (cell.textLabel?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let returnedView = UIView()
        returnedView.backgroundColor = UIColor.clear    //To make tableView header transparent
        return returnedView
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        var result = String()
        section == 0 ? (result = "") : (result = " ")
        return result
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        if moreArray[indexPath.section][indexPath.row] == "Sign Out"
        {
            dataConnection.signOut(completion:
            { message in
                message == "Done" ? (self.performSegue(withIdentifier: "goToIndex", sender: self)) : self.makeAlert(message: "Error Siging Out")
            })
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 10.0
    }
    
    //MARK:- To Make Alert
    func makeAlert(message: String)
    {
        let alert = UIAlertController(title: "Traffik Now", message: "\(message)", preferredStyle: .alert)
        let restartaction = UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
        })
        alert.addAction(restartaction)
        present(alert, animated: true, completion: nil)
    }
}

extension moreTableViewController : IndicatorInfoProvider
{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "More")
    }
}


