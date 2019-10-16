//
//  TabBarCtrl.swift
//  SU Campus

//  Copyright © 2019 www.d-tech.com. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate
{
    let button = UIButton.init(type: .custom)
    let dataConnection = Data()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.delegate = self
        setupMiddleButton()
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.frame = CGRect.init(x: self.tabBar.center.x - 28, y: self.view.bounds.height - 73, width: 57, height: 57)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
    }
    
    func setupMiddleButton()
    {
        button.setTitle("+", for: .normal)
        button.titleLabel!.font =  UIFont(name: "HelveticaNeue-Thin", size: 40)
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        button.contentVerticalAlignment = UIControl.ContentVerticalAlignment.top

        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        
        button.backgroundColor =  #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        button.layer.cornerRadius = 29
        self.view.insertSubview(button, aboveSubview: self.tabBar)
    }
    
    @objc func buttonAction(sender: UIButton!)
    {
        dataConnection.defaults.bool(forKey: "checkSignIn") ? (performSegue(withIdentifier: "goToPost(index)", sender: self)) : (performSegue(withIdentifier: "goToLogin", sender: self))
    }
    
    @IBAction func MoreButton_Clicked(_ sender: Any)
    {
        dataConnection.defaults.bool(forKey: "checkSignIn") ? (performSegue(withIdentifier: "goToMore", sender: self)) : (performSegue(withIdentifier: "goToLogin", sender: self))
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue)
    {
        
    }
}

