//
//  MainViewController.swift
//  E-ponto
//
//  Created by Denis Nascimento on 01/06/17.
//  Copyright © 2017 Denis Nascimento. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var leftContraings: NSLayoutConstraint!
    @IBOutlet var leftMainMenu: UIView!
    
    //vars
    var mainMenuActive = false


    override func viewDidLoad() {
        super.viewDidLoad()

        //Properties of Views
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //Actions
    @IBAction func openMainMenu(_ sender: Any) {
        if (mainMenuActive) {
            leftContraings.constant = -187
        } else {
            leftContraings.constant = 0
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        mainMenuActive = !mainMenuActive
    }

}
