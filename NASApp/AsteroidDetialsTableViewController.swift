//
//  AsteroidDetialsTableViewController.swift
//  NASApp
//
//  Created by Andrea Miotto on 27/03/17.
//  Copyright © 2017 Andrea Miotto. All rights reserved.
//

import UIKit

class AsteroidDetailsTableViewController: UITableViewController {
    
    var asteroid: Asteroid?
    
    @IBOutlet weak var hazardousLabel: UILabel!
    @IBOutlet weak var approachDateLabel: UILabel!
    @IBOutlet weak var absoluteMagnitudeLabel: UILabel!
    @IBOutlet weak var estimetedDiameterMinLabel: UILabel!
    @IBOutlet weak var estimatedDiameterMaxLabel: UILabel!
    @IBOutlet weak var missDistanceLabel: UILabel!
    @IBOutlet weak var velocityLabel: UILabel!
    

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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 3: return 2
        default: return 1
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
