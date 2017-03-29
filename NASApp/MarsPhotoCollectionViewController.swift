//
//  MarsPhotoCollectionViewController.swift
//  NASApp
//
//  Created by Andrea Miotto on 28/03/17.
//  Copyright © 2017 Andrea Miotto. All rights reserved.
//

import UIKit

/** the cell identifier */
private let reuseIdentifier = "roverItem"

class MarsPhotoCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //----------------------
    // MARK: - Variables
    //----------------------
    
    ///It keeps track of the selected rover
    var selectedRover: Rover?
    
    ///It keeps track of the items for the selected rover
    var roverItems: [RoverItem]? {
        didSet {
            self.fetchImages()
        }
    }
    
    ///The images to print out
    var images: [UIImage] = []
    
    //----------------------
    // MARK: - View Functions
    //----------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "\(selectedRover!.rawValue.capitalized)'s photos"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //----------------------
    // MARK: - Methods
    //----------------------
    
    
    ///func the fetches the images from the web for each rover item
    func fetchImages() {
        for item in self.roverItems! {
            getImage(withURL: item.imageURL , withID: item.id)
        }
    }
    
    ///func the fetches the image for one rover item
    func getImage(withURL url: String, withID id:String) {
        if let cachedImage = imageCache.image(for: URLRequest(url: URL(string: url)!), withIdentifier: id) {
            print("daily image fetched from the cache")
            self.images.append(cachedImage)
            self.collectionView?.reloadData()
        } else {
            NetworkManager.fetchImage(url: url, withIdentifier: id, completion: { image in
                // Add to the cache
                print("daily image added to the cache")
                imageCache.add(image, for: URLRequest(url: URL(string: url)!), withIdentifier: id)
                self.images.append(image)
                self.collectionView?.reloadData()
            })
        }
    }
    
    //----------------------
    // MARK: - UICollectionViewDataSource
    //----------------------

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RoverItemCollectionViewCell
    
    
        cell.imageView.image = images[indexPath.row]
        return cell
    }

    //----------------------
    // MARK: - UICollectionViewDelegateFlowLayout
    //----------------------
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (self.view.frame.width/3)-5
        return CGSize(width: size, height: size)
    }
    
    //----------------------
    // MARK: - Navigation
    //----------------------
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showImage" {
            if let indexPath = self.collectionView?.indexPathsForSelectedItems {
                if let nextVC = segue.destination as? ImageViewController {
                    let index = indexPath[0]
                    nextVC.image = self.images[index.row]
                }
            }
            
            
            
        }
    }

    
}
