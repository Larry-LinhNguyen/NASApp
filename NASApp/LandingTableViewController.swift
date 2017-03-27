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

   

    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDaily" {
            if let nextVC = segue.destination as? DailyTableViewController {
                nextVC.daily = self.daily
            }
        }
        
        if segue.identifier == "showCollisions" {
            if let nextVC = segue.destination as? CollisionEventsTableViewController {
                nextVC.asteroids = self.asteroids
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "showDaily" {
            if (self.daily?.image == nil || self.daily?.title == nil || self.daily?.explanation == nil) {
                ShowDataUnaviableAlert()
                return false
            }
            return true
        }
        
        if identifier == "showCollisions" {
            if (self.asteroids.count < 1) {
                ShowDataUnaviableAlert()
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
            let objects = json["near_earth_objects"].dictionaryValue
            for objectsByDate in objects {
                let flatted = objectsByDate.value.flatMap { $0 }
                for object in flatted {
                    do {
                        try self.asteroids.append(Asteroid(json: object.1))
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
    
    func ShowDataUnaviableAlert() {
        displayAlert(title: "Fetching Data", message: "We are moving the satellites for you, retry in a moment!")
    }

}
