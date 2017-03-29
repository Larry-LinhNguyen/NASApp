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


/** This is the class for the **Landing Page**, the entry point */
class LandingTableViewController: UITableViewController {
    
    //----------------------
    // MARK: - Variables
    //----------------------
    
    ///It stores the data of the daily imagege
    var daily: Daily?
    ///It stores all the data for the asteroids
    var asteroids: [Asteroid] = []
    
    //----------------------
    // MARK: - View funcs
    //----------------------
    
    override func viewWillAppear(_ animated: Bool) {
        //Start to download the data even beofre the view appears
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
    

    //----------------------
    // MARK: - Methods
    //----------------------
    
    /** This func will download the daily data from the API */
    func fetchingDaily() {
        NetworkManager.fetchDaily {json in
            do {
                try self.daily = Daily(json: json)
            } catch  let error {
                self.displayAlert(title: "Error", message: "\(error)")
            }
        }
    }
    
    /** This func will download the asteroids data from the API */
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
    
    //----------------------
    // MARK: - Helpers
    //----------------------
    
    /** This func will display the proper alert message for unaviable data */
    func showDataUnaviableAlert() {
        displayAlert(title: "Fetching Data", message: "We are moving the satellites for you, retry in a moment!")
    }
    
    /**This func will display an Alert */
    func displayAlert(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    //----------------------
    // MARK: - Table view data source
    //----------------------
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    //----------------------
    // MARK: - Navigation
    //----------------------
    
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
            //if the daily is nil, prompt an alert
            if (self.daily?.image == nil || self.daily?.title == nil || self.daily?.explanation == nil) {
                showDataUnaviableAlert()
                return false
            }
            return true
        }
        
        if identifier == "showCollisions" {
            //if the asteroids aren't downloaded, prompt an alert
            if (self.asteroids.count < 1) {
                showDataUnaviableAlert()
                return false
            }
            return true
        }
        
        // by default, transition
        return true
    }

}
