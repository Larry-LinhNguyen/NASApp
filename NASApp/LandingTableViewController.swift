//
//  LandingTableViewController.swift
//  NASApp
//
//  Created by Andrea Miotto on 23/03/17.
//  Copyright © 2017 Andrea Miotto. All rights reserved.
//

import UIKit
import AlamofireImage

class LandingTableViewController: UITableViewController {
    
    let imageCache = AutoPurgingImageCache()
    
    var daily = Daily()
    
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
            if (self.daily.image == nil || self.daily.title == nil || self.daily.explanation == nil) {
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
            let imageULR = json["url"].stringValue
            
            self.daily.title = json["title"].stringValue
            self.daily.explanation = json["explanation"].stringValue
            
            // Fetch the image cache
            let id = self.getDate()
            
            if let cachedImage = self.imageCache.image(for: URLRequest(url: URL(string: imageULR)!), withIdentifier: id) {
                print("daily image fetched from the cache")
                self.daily.image = cachedImage
            } else {
                NetworkManager.fetchImage(url: imageULR, withIdentifier: id, completion: { image in
                    // Add to the cache
                    print("daily image added to the cache")
                    self.imageCache.add(image, for: URLRequest(url: URL(string: imageULR)!), withIdentifier: id)
                    self.daily.image = image
                })
            }
        }
    }
    
    func fetchingAsteroids() {
        NetworkManager.fetchAsteroids { json in
            print(json)
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
