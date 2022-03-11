//
//  UIImageview+.swift
//  List
//
//  Created by Miguel Goñi on 11/3/22.
//  Copyright © 2022 Miguel Goñi. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {

    func loadImage(_ URLString: String, placeHolder: UIImage = UIImage(named: "placeholder") ?? UIImage()) {

        self.image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
            self.image = cachedImage
            return
        }

        if let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in

                if error != nil {
                    debugPrint("ERROR LOADING IMAGES FROM URL: \(String(describing: error))")
                    DispatchQueue.main.async { [weak self] in
                        self?.image = placeHolder
                    }
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                            self?.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
}
