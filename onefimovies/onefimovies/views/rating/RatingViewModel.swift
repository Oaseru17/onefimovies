//
//  RatingViewModel.swift
//  onefimovies
//
//  Created by gHOST on 7/3/19.
//  Copyright © 2019 onefi. All rights reserved.
//

import Foundation

//Rating view model
struct RatingViewModel {
    // variable declaration for view model
    let value: String
    let source: String
    
    // intiliazation of view model using the rating data
    init(ratingdata: Rating) {
        self.value = ratingdata.Value
        self.source = ratingdata.Source
        
        
    }
    
}
