//
//  LandingTableViewController.swift
//  NASApp
//
//  Created by Andrea Miotto on 23/03/17.
//  Copyright © 2017 Andrea Miotto. All rights reserved.
//

import UIKit
import AlamofireImage
import SwiftyJSON

class LandingTableViewController: UITableViewController {
    
    var daily: Daily?
    var asteroids: [Asteroid] = []
    
    
    override func viewWillAppear(_ animated: Bool) {
        fetchingDaily()
        fetchingAsteroids()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationItem.backBarButtonItem?.title = "Back"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDaily" {
            if let nextVC = segue.destination as? DailyTableViewController {
                nextVC.daily = self.daily
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "showDaily" {
            if (self.daily?.image == nil || self.daily?.title == nil || self.daily?.explanation == nil) {
                displayAlert(title: "Fetching Data", message: "We are moving the satellites for you, retry in a moment!")
                return false
            }
            return true
        }
        
        // by default, transition
        return true
    }
    
    func fetchingDaily() {
        NetworkManager.fetchDaily {json in
            //print(json)
            
            do {
                try self.daily = Daily(json: json)
            } catch  let error {
                self.displayAlert(title: "Error", message: "\(error)")
            }
            
        }
    }
    
    func fetchingAsteroids() {
        NetworkManager.fetchAsteroids { json in
            //print(json)
            let objects = json["near_earth_objects"].dictionaryValue
            print(objects.count)
            for objectsByDate in objects {
                //Convert into an array
                let arrayOfObjectsByDate = objectsByDate.value.arrayValue
                for object in arrayOfObjectsByDate {
                    do {
                        print(object)
                        //try self.asteroids.append(Asteroid(json: object))
                        //print(self.asteroids)
                    } catch let error {
                        self.displayAlert(title: "Error", message: "\(error)")
                    }
                }
                
            }
            

        }
    }
    
    
    func getDate() -> String {
        let date = Date()
        //creating the formatter and choosing the styles
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
            
        //updating the title
        return formatter.string(from: date)
    }
    
    /**This func will display an Alert */
    func displayAlert(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
    }

}
