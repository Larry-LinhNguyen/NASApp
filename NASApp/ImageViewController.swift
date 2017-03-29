//
//  ImageViewController.swift
//  NASApp
//
//  Created by Andrea Miotto on 28/03/17.
//  Copyright © 2017 Andrea Miotto. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    //----------------------
    // MARK: - Variables
    //----------------------
    var image: UIImage?
    
    //----------------------
    // MARK: - Outlets
    //----------------------
    @IBOutlet weak var imageView: UIImageView!
    
    //----------------------
    // MARK: - View Funcs
    //----------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        // update the image
        self.imageView.image = image!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
