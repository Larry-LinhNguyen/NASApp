//
//  AsteroidDetailsTableViewController.swift
//  NASApp
//
//  Created by Andrea Miotto on 27/03/17.
//  Copyright © 2017 Andrea Miotto. All rights reserved.
//

import UIKit

class AsteroidDetailsTableViewController: UITableViewController {
    
    //----------------------
    // MARK: - Variables
    //----------------------
    
    ///It keeps track of the selected asteroid
    var asteroid: Asteroid?
    
    //----------------------
    // MARK: - Outlets
    //----------------------
    
    @IBOutlet weak var hazardousLabel: UILabel!
    @IBOutlet weak var approachDateLabel: UILabel!
    @IBOutlet weak var absoluteMagnitudeLabel: UILabel!
    @IBOutlet weak var estimetedDiameterMinLabel: UILabel!
    @IBOutlet weak var estimatedDiameterMaxLabel: UILabel!
    @IBOutlet weak var missDistanceLabel: UILabel!
    @IBOutlet weak var velocityLabel: UILabel!
    
    //----------------------
    // MARK: - View Functions
    //----------------------
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let asteroid = self.asteroid {
            self.title = "\(asteroid.name)"
            hazardousLabel.text = "\(asteroid.hazardous)"
            approachDateLabel.text = "\(asteroid.approachDate)"
            absoluteMagnitudeLabel.text = "\(asteroid.absoluteMagnitude)"
            estimetedDiameterMinLabel.text = "\(asteroid.estimetedDiameter.0) m"
            estimatedDiameterMaxLabel.text = "\(asteroid.estimetedDiameter.1) m"
            missDistanceLabel.text = "\(asteroid.missDistance) km"
            velocityLabel.text = "\(asteroid.velocity) km/s"
            
        } else {
            self.title = "Selected Asteroid"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //----------------------
    // MARK: - Table view data source
    //----------------------

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 3: return 2
        default: return 1
        }
    }
}
