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

class NetworkManager {
    
    // MARK: - Properties
    
    private static let apy_key = "EYMl6SBRowwaZjUZdhreW2XbO0AqC2VLVycXAZie"
    private static let base_url = "https://api.nasa.gov/"
    static let shared = NetworkManager()

    
    // MARK: - Connections
    class func getDaily(response: (JSON) -> ()) {
        //Setting the url for the request
        let url = "\(base_url)planetary/apod?api_key=\(apy_key)"
        //Making the request
        Alamofire.request(url, method: .get).validate().responseJSON{ response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                response(json)
                //print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
    }

    
}

