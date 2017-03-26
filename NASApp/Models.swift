//
//  Models.swift
//  NASApp
//
//  Created by Andrea Miotto on 23/03/17.
//  Copyright © 2017 Andrea Miotto. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
//import AlamofireImage

// MARK: - Protocol

/**The JSONDecodable protocol, to which every type has to conform **/
protocol JSONDecodable {
    init(json: JSON) throws
}

// MARK: - Errors Type

enum NASAPPError: Error {
    case NoDecodable(String)
    case CantLoadData(String)
}

// MARK: - Daily Model

class Daily: JSONDecodable {
    var imageURL: String
    var title: String
    var explanation: String
    var image: UIImage?
    
    init(withTitle title: String, imageURL: String, explanation: String) {
        self.title = title
        self.explanation = explanation
        self.imageURL = imageURL
        
        getImage(withURL: self.imageURL, withID: self.title)
    }
    
    required convenience init(json: JSON) throws {
        guard let title = json["title"].string, let imageURL = json["url"].string, let explanation = json["explanation"].string else {
            throw NASAPPError.NoDecodable("At least one of the properties in not decodable, be sure the decoding pattern matches to the API schema")
        }
        
        self.init(withTitle: title, imageURL: imageURL, explanation: explanation)
    }
    
}

//Adding methods
extension Daily {
    func getImage(withURL url: String, withID id:String) {
        if let cachedImage = imageCache.image(for: URLRequest(url: URL(string: url)!), withIdentifier: id) {
            print("daily image fetched from the cache")
            self.image =  cachedImage
        } else {
            NetworkManager.fetchImage(url: url, withIdentifier: id, completion: { image in
                // Add to the cache
                print("daily image added to the cache")
                imageCache.add(image, for: URLRequest(url: URL(string: url)!), withIdentifier: id)
                self.image = image
            })
        }

    }
}
