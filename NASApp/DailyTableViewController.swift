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
    
    var dailyImage: UIImage? {
        didSet {
            print(dailyImage)
            self.imageView.image = dailyImage
            self.tableView.reloadData()
        }
    }
    
    var dailyTitle: String? {
        didSet {
            self.titleLabel.text = dailyTitle
        }
    }
    
    var dailyExplanation: String? {
        didSet {
            self.explanationLabel.text = dailyExplanation
            self.tableView.reloadData()
        }
    }

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var explanationLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - TABALE VIEW DATA SOURCE

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
    
    // MARK: - NETWORKING

}
