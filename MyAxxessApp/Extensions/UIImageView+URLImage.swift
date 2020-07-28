//
//  UIImageView+URLImage.swift
//  MyAxxessApp
//
//  Created by Sanjay Mohnani on 28/07/20.
//  Copyright © 2020 Sanjay Mohnani. All rights reserved.
//
import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView{
    /// This loadThumbnail function is used to download thumbnail image using urlString
    /// This method also using cache of loaded thumbnail using urlString as a key of cached thumbnail.
    func loadThumbnail(urlSting: String, completion: @escaping (_ flag: Bool) -> Void) {
        guard let url = URL(string: urlSting) else {
            completion(false)
            return
        }
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlSting as AnyObject) {
            image = imageFromCache as? UIImage
            completion(true)
            return
        }
        APIManager.downloadImage(url: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                guard let imageToCache = UIImage(data: data) else { return }
                imageCache.setObject(imageToCache, forKey: urlSting as AnyObject)
                self.image = UIImage(data: data)
                completion(true)
            case .failure(_):
                //self.image = UIImage(named: "noImage")
                completion(false)
            }
        }
    }
    
    func loadThumbnail(urlSting: String, row :Int, completion: @escaping (_ flag: Bool, _ image : UIImage?, _ row: Int) -> Void) {
        guard let url = URL(string: urlSting) else {
            completion(false, nil, row)
            return
        }
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlSting as AnyObject) {
            image = imageFromCache as? UIImage
            completion(true, image, row)
            return
        }
        APIManager.downloadImage(url: url) { [weak self] result in
            guard let _ = self else { return }
            switch result {
            case .success(let data):
                guard let imageToCache = UIImage(data: data) else { return }
                imageCache.setObject(imageToCache, forKey: urlSting as AnyObject)
                let image = UIImage(data: data)
                completion(true, image, row)
            case .failure(_):
                //self.image = UIImage(named: "noImage")
                completion(false, nil, row)
            }
        }
    }
    
    func getImageFromCache(urlSting: String) -> UIImage?{
        if let imageFromCache = imageCache.object(forKey: urlSting as AnyObject) {
            if let image = imageFromCache as? UIImage{
                return image
            }
        }
        return nil
    }
}
