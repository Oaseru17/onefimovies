//
//  ListingWebController.swift
//  onefimovies
//
//  Created by gHOST on 6/3/19.
//  Copyright © 2019 onefi. All rights reserved.
//

import Foundation
import SwiftyJSON
class ListingWebController{
    //fetch data from server using closure
    public static func fetchData( request : MovieRequestData,completion: @escaping (_ result: MovieRespondData?, _ serverState: serverState) -> Void) {
     // create url and detail params
        var url = URLComponents(string: WebApiconstant.fetchurl)!
        url.queryItems = [
            URLQueryItem(name: "apikey", value: WebApiconstant.apikey),
            URLQueryItem(name: "t", value: request.name),
            URLQueryItem(name: "y", value: request.year)
        ]
        
        var request = URLRequest(url: url.url!)
        //set request headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = WebApiconstant.getRequest
  
     //reuest for data from server using urlsession
        let task = URLSession.shared.dataTask(with: request as URLRequest){data, response, error in
            guard error == nil && data != nil else{
                completion(nil,serverState.serverError)
                return
            }
            
            //check reponse status code
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != serverState.ok.rawValue{
                completion(nil,serverState.serverError)
                return
            }
            
            do {
                //create json from recieved data
                let json = try JSON(data: data!)
                //get reponse string
                let code = json["Response"].stringValue
                //get bool value of string
                if let _ = code.bool {
                    let decoder = JSONDecoder()
                    let returnData  = try! decoder.decode(MovieRespondData.self, from: json.rawData())
                    //call completion with data
                    completion(returnData,serverState.ok)
                }else{
                    completion(nil,serverState.jsonError )
                }
            }catch{
                completion(nil,serverState.jsonError)
            }
        }
        
        task.resume()
    }
}
