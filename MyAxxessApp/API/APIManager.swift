//
//  APIManager.swift
//  MyAxxessApp
//
//  Created by Sanjay Mohnani on 27/07/20.
//  Copyright © 2020 Sanjay Mohnani. All rights reserved.
//

import Foundation
import Alamofire

/// Result enum is a generic for any type of value
/// with success and failure case
public enum Result<T> {
    case success(T)
    case failure(Error)
}

class APIManager {
    class func getRecords(completion: @escaping ([Record]?, String?) -> Void){
        Alamofire.request("https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/challenge.json").responseJSON { response in
            let json = response.data
            do{
                let decoder = JSONDecoder()
                let list = try decoder.decode([Record].self, from: json!)
                print(list)
                completion(list, nil)
            }catch let error{
                print(error)
            }
            completion(nil, "Error")
        }
    }
    
    public class func downloadImage(url: URL,
                                     completion: @escaping (Result<Data>) -> Void) {
        Alamofire.request(url, method: .get)
            .validate()
            .responseData(completionHandler: { (responseData) in
                guard let data = responseData.data else {
                    return
                }
                DispatchQueue.main.async() {
                    completion(.success(data))
                }
            })
    }
}
