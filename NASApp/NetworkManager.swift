//
//  NetworkManager.swift
//  NASApp
//
//  Created by Andrea Miotto on 23/03/17.
//  Copyright © 2017 Andrea Miotto. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit
import AlamofireImage

class NetworkManager {
    
    // MARK: - Properties
    
    private static let apy_key = "EYMl6SBRowwaZjUZdhreW2XbO0AqC2VLVycXAZie"
    private static let base_url = "https://api.nasa.gov/"
    static let shared = NetworkManager()

    
    // MARK: - Connections
    class func fetchDaily(completion: @escaping (JSON) -> ()) {
        //Setting the url for the request
        let url = "\(base_url)planetary/apod?api_key=\(apy_key)"
        //Making the request
        Alamofire.request(url, method: .get).validate().responseJSON{ response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completion(json)
                //print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    class func fetchImage(url: String, withIdentifier: String, completion: @escaping (UIImage) -> ()) {
        Alamofire.request(url).responseImage { response in
            switch response.result {
            case .success(let value):
                completion(value)
                
                /* Update the cell
                DispatchQueue.main.async(execute: {
                    //FIXME: we need to update the cell with the just downloaded image
                    cell.poster.image = image
                })
                */
                
            case .failure(let error):
                print(error)
            }
        }
    }

    
}

