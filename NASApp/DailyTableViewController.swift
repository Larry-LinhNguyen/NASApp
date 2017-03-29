//
//  DailyTableViewController.swift
//  NASApp
//
//  Created by Andrea Miotto on 23/03/17.
//  Copyright © 2017 Andrea Miotto. All rights reserved.
//

import UIKit
import Alamofire

class DailyTableViewController: UITableViewController {
    
    //----------------------
    // MARK: - Variables
    //----------------------
    
    /** It keep track of the daily*/
    var daily: Daily?
    
    //----------------------
    // MARK: - Outlets
    //----------------------

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var explanationLabel: UILabel!
    
    //----------------------
    // MARK: - View Functions
    //----------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //----------------------
    // MARK: - Methods
    //----------------------
    
    ///It updates the layout with the right info
    func setLayout() {
        self.titleLabel.text = daily?.title
        self.imageView.image = daily?.image
        self.explanationLabel.text = daily?.explanation
    }

    //----------------------
    // MARK: - Table view data source
    //----------------------

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

}
