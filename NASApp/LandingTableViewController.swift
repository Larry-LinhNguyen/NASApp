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
                NetworkManager.fetchDaily {json in
                    //print(json)
                    let imageULR = json["url"].stringValue
 
                    nextVC.dailyTitle = json["title"].stringValue
                    nextVC.dailyExplanation = json["explanation"].stringValue
                    
                    // Fetch the image cache
                    let id = self.getDate()
                    
                    if let cachedImage = self.imageCache.image(for: URLRequest(url: URL(string: imageULR)!), withIdentifier: id) {
                        print("image fetched from the cache")
                        nextVC.dailyImage = cachedImage
                    } else {
                        NetworkManager.fetchImage(url: imageULR, withIdentifier: id, completion: { image in
                            // Add to the cache
                            print("image added to the cache")
                            self.imageCache.add(image, for: URLRequest(url: URL(string: imageULR)!), withIdentifier: id)
                            nextVC.dailyImage = image
                        })
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

}
