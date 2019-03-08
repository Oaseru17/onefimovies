//
//  ListingViewModel.swift
//  onefimovies
//
//  Created by gHOST on 6/3/19.
//  Copyright © 2019 onefi. All rights reserved.
//


import Foundation
//listing view model
struct ListingViewModel {
    // variable declaration for view model
    let title: String
    let posterurl: String
    let year:String
    let director:String
      // intiliazation of view model using the moveireponds DI
    init(moviedata: MovieRespondData) {
        self.title = moviedata.Title
        self.posterurl = moviedata.Poster
        self.year = moviedata.Year
        self.director = moviedata.Director
        
       
    }
    
}
