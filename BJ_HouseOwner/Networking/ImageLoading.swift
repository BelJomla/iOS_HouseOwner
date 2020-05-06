//
//  ImageLoading.swift
//  BJ_HouseOwner
//
//  Created by Project X on 5/6/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import Foundation
import UIKit

struct ImageLoading {
    static func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    static func downloadImage(from urlString:String, for image: UIImageView){
        let url = URL(string: urlString)!
        ImageLoading.downloadImage(from: url, for:image)
        
    }
    
    static func downloadImage(from url: URL, for image: UIImageView) {
        print("Download Started")
        ImageLoading.getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                image.image = UIImage(data: data)
            }
        }
    }
}
