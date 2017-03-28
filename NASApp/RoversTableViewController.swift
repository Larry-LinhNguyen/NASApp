//
//  RoversTableViewController.swift
//  NASApp
//
//  Created by Andrea Miotto on 28/03/17.
//  Copyright © 2017 Andrea Miotto. All rights reserved.
//

import UIKit

class RoversTableViewController: UITableViewController {

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
        return 3
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            if let nextVC = segue.destination as? MarsPhotoCollectionViewController {
                switch indexPath.row {
                case 0: nextVC.selectedRover = Rover.curiosity
                case 1: nextVC.selectedRover = Rover.opportunity
                case 2: nextVC.selectedRover = Rover.spirit
                default: nextVC.selectedRover = Rover.curiosity
                }
            }
        }
    }

}
