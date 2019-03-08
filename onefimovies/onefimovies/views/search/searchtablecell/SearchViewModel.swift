//
//  SearchViewModel.swift
//  onefimovies
//
//  Created by gHOST on 7/3/19.
//  Copyright © 2019 onefi. All rights reserved.
//

import Foundation

//Search view model
struct SearchViewModel {
    // variable declaration for view model
    let title: String
    let year:String
    
    // intiliazation of view model using the moveireponds data
    init(moviedata: MovieRespondData) {
        self.title = moviedata.Title
        self.year = moviedata.Year
    }
    
}

