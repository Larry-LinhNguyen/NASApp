//
//  MarsPhotoCollectionViewController.swift
//  NASApp
//
//  Created by Andrea Miotto on 28/03/17.
//  Copyright © 2017 Andrea Miotto. All rights reserved.
//

import UIKit

private let reuseIdentifier = "roverItem"

class MarsPhotoCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var selectedRover: Rover?
    var roverItems: [RoverItem]? {
        didSet {
            self.fetchImages()
        }
    }
    var images: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "\(selectedRover!.rawValue.capitalized)'s photos"


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchImages() {
        for item in self.roverItems! {
            getImage(withURL: item.imageURL , withID: item.id)
        }
    }
    
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

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

    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (self.view.frame.width/3)-5
        return CGSize(width: size, height: size)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //presentImage(image: self.images[indexPath.row])
    }
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showImage" {
            if let indexPath = self.collectionView?.indexPathsForSelectedItems {
                if let nextVC = segue.destination as? ImageViewController {
                    let index = indexPath[0]
                    nextVC.imageView.image = self.images[index.row]
                }
            }
            
            
            
        }
    }

    
}
