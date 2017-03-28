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
import CoreLocation

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
                print("Daily data downloaded")
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
            case .failure(let error):
                print(error)
            }
        }
    }
    
    class func fetchAsteroids(completion: @escaping (JSON) -> ()) {
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let start_date = formatter.string(from: date)
        let time = TimeInterval(60*60*24*7)
        let end_date = formatter.string(from: date.addingTimeInterval(time))
        
        //let end_date = start_date + 7
        //Setting the url for the request
        let url = "\(base_url)neo/rest/v1/feed?start_date=\(start_date)&end_date=\(end_date)&detailed=false&api_key=\(apy_key)"
        //Making the request
        Alamofire.request(url, method: .get).validate().responseJSON{ response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completion(json)
                print("Asteroids data downloaded")
                //print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
    }

    
}

