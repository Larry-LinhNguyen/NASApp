//
//  RoversTableViewController.swift
//  NASApp
//
//  Created by Andrea Miotto on 28/03/17.
//  Copyright © 2017 Andrea Miotto. All rights reserved.
//

import UIKit

class RoversTableViewController: UITableViewController {
    
    //----------------------
    // MARK: - Variables
    //----------------------
    
    var roverItemsCollection: ([RoverItem], [RoverItem], [RoverItem]) = ([],[],[])
    
    //----------------------
    // MARK: - View Functions
    //----------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: nil, action: nil)
        fetchingForAllRovers()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //----------------------
    // MARK: - Table view data source
    //----------------------

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    
    //----------------------
    // MARK: - Navigation
    //----------------------

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            if let nextVC = segue.destination as? MarsPhotoCollectionViewController {
                switch indexPath.row {
                case 0:
                    nextVC.selectedRover = Rover.curiosity
                    nextVC.roverItems = self.roverItemsCollection.0
                case 1:
                    nextVC.selectedRover = Rover.opportunity
                    nextVC.roverItems = self.roverItemsCollection.1
                case 2:
                    nextVC.selectedRover = Rover.spirit
                    nextVC.roverItems = roverItemsCollection.2
                default: break
                }
            }
        }
    }
    
    //----------------------
    // MARK: - Methods
    //----------------------
    
    ///func that fetch items for all the rovers
    func fetchingForAllRovers() {
        self.fetchingRoverItems(rover: Rover.curiosity)
        self.fetchingRoverItems(rover: Rover.opportunity)
        self.fetchingRoverItems(rover: Rover.spirit)
    }
    
    ///func tht fetch the items for the selected rover
    func fetchingRoverItems(rover: Rover) {
        
        //FIXME: - "Sol" should not be hardocoded
        
        /* ------------
         for this mvp implementation the sol is hardcoded, in the future
         the user will have the possibility to choose the sol */
        var sol = 0
        switch rover {
        case .curiosity: sol = 1634
        case .opportunity: sol = 4650
        case .spirit: sol = 500
        }
        /* ------------ */
        
        NetworkManager.fetchRoversPhotos(rover: rover, sol: sol) {rover, json in
            for roverItem in json["photos"] {
                do {
                    switch rover {
                    case .curiosity: try self.roverItemsCollection.0.append(RoverItem(json: roverItem.1))
                    case .opportunity: try self.roverItemsCollection.1.append(RoverItem(json: roverItem.1))
                    case .spirit: try self.roverItemsCollection.2.append(RoverItem(json: roverItem.1))
                    }
                } catch  let error {
                    self.displayAlert(title: "Error", message: "\(error)")
                }
            }
            
            
        }
    }
    
    //----------------------
    // MARK: - Helpers
    //----------------------
    
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
}
