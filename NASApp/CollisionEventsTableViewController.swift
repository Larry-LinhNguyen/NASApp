//
//  CollisionEventsTableViewController.swift
//  NASApp
//
//  Created by Andrea Miotto on 23/03/17.
//  Copyright © 2017 Andrea Miotto. All rights reserved.
//

import UIKit

class CollisionEventsTableViewController: UITableViewController {
    
    var asteroids : [Asteroid] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: nil, action: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return asteroids.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CollisionTableViewCell
        let asteroid = self.asteroids[indexPath.row]
        configureCell(cell: cell, withEntry: asteroid)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "APPROACHING ASTEROIDS"
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).backgroundView?.backgroundColor = UIColor.black.withAlphaComponent(1)
        (view as! UITableViewHeaderFooterView).textLabel?.textColor = UIColor.white.withAlphaComponent(0.4)
        (view as! UITableViewHeaderFooterView).textLabel?.font = UIFont(name: "Helvetica", size: 15)
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAsteroid" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                if let nextVC = segue.destination as? AsteroidDetailsTableViewController {
                    nextVC.asteroid = asteroids[indexPath.row]
                }
            }
            
        }
    }
    
    
    
    /**This func will style the cell prperly */
    func configureCell(cell: CollisionTableViewCell, withEntry entry: Asteroid) {
        
        //setting the easy stuff
        cell.nameLabel.text = entry.name
        cell.dateLabel.text = entry.approachDate
        if !entry.hazardous {
            cell.hazardousLabel.isHidden = true
        } else {
            cell.hazardousLabel.isHidden = false
        }
    }

}
