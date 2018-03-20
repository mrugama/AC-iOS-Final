//
//  GoogleImageSearcher.swift
//  AC-iOS-Final
//
//  Created by C4Q on 3/1/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit


struct OnlineImage {
    let thumbnail : UIImage?
}

class ImageSearcher {
    private init(){}
    
    static let manager = ImageSearcher()
    let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    func searchForTerm(term: String, page: Int, completion: @escaping (_ results: [OnlineImage]?, _ error: Error?) -> Void) {
        let keyAPI = "8229630-b710c3207f61656c89325aa45"
        let urlString = "https://pixabay.com/api/?key=\(keyAPI)&q=yellow+flowers&image_type=photo"
        if let search = URL(string: urlString) {
            urlSession.dataTask(with: search, completionHandler: { (data, response, error) in
                if let error = error {
                    completion(nil, error)
                }
                if let data = data {
                    do {
                        let resultAny = try? JSONSerialization.jsonObject(with: data, options: [])
                        if let dict = resultAny as? [String: Any] {
                            if let resultsDict = dict["results"] as? [[String: Any]] {
                                do {
                                    let googlePhotos: [OnlineImage] = try resultsDict.map{ photoDict in
                                        let thumbNailURL = photoDict["tbUrl"] as! String
                                        print(thumbNailURL)
                                        let imageData = try Data(contentsOf: URL(string: thumbNailURL)!)
                                        let image = UIImage.init(data: imageData)
                                        let imageGoogle = OnlineImage(thumbnail: image)
                                        return imageGoogle
                                    }
                                    completion(googlePhotos, nil)
                                } catch {
                                    completion(nil, error)
                                }
                            }
                        }
                    }
                }
            }).resume()
        } else {
            print("URL couldn't resolved")
        }
    }
}
