//
//  StartingViewController.swift
//  NASApp
//
//  Created by Andrea Miotto on 20/03/17.
//  Copyright © 2017 Andrea Miotto. All rights reserved.
//

import UIKit

class StartingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func collisionAction(_ sender: Any) {
        print("Checking for collisions...")
    }
    
    
    @IBAction func marsAction(_ sender: Any) {
        print("Connecting to the rover...")
    }

    @IBAction func earthAction(_ sender: Any) {
        print("Connecting to the satellite...")
    }

}

