//
//  DataManager.swift
//  onefimovies
//
//  Created by gHOST on 7/3/19.
//  Copyright © 2019 onefi. All rights reserved.
//

class DataManager {
   //hold the moviedatalist
    //this is used mainly within the search controller
    var movielistData: [MovieRespondData] = []
    //a simple singleton to return a datamanger object
    class var sharedManager: DataManager {
        struct Static {
            static let instance = DataManager()
        }
        return Static.instance
    }
}
