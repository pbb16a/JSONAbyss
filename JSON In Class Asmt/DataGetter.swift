//
//  DataGetter.swift
//  JSON In Class Asmt
//
//  Created by Paula Berggren on 1/28/20.
//  Copyright © 2020 Paula Berggren. All rights reserved.
//

import UIKit

class DataGetter: NSObject {
    
    let MYJSONURL = "https://api.myjson.com/bins/zs1by"
//    let MYJSONURL = "https://api.myjson.com/bins/1e5uji"
    //(Links to an external site.)
    
        var dataArray = [ "No data yet"]
    
        func getData(completion: @escaping(_ success: Bool)->()) {
                var success = true
            
            let  actualUrl = URL(string: MYJSONURL)
            
            let task = URLSession.shared.dataTask(with: actualUrl!) {
                (data, response, error) in
                
                guard let _ = data, error == nil else {
                    //we has an error ot the data didnt come back
                    success = false
                    return
                }
                
                if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary{
                    
                    //printing JSON to console
                    print(jsonObj.value(forKey: "key")!)
                    
                    //getting characters tag array frim json and converting it to NSArray
                    if let movieArray = jsonObj.value(forKey: "key") as? Array<String>{ self.dataArray = movieArray
                    }
                }
                
                //call back the completion heandler that was passed in notifying to do things (we dont care what)
                completion(success)
            }
            task.resume()
    }
}
