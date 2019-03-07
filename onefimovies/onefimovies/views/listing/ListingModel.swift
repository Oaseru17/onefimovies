//
//  ListingModel.swift
//  onefimovies
//
//  Created by gHOST on 6/3/19.
//  Copyright © 2019 onefi. All rights reserved.
//


import Foundation
//movie request struct
struct MovieRequestData: Decodable {
    let name: String
    let year: String
}
//rating struct
struct Rating: Codable {
    var Source: String
    var Value: String
    
}

//movie reponds struct
struct MovieRespondData: Codable {
    var Title: String
    var Year: String
    var Rated: String
    var Released: String
    var Runtime: String
    var Genre: String
    var Director: String
    var Writer: String
    var Actors: String
    var Plot: String
    var Language: String
    var Country: String
    var Awards: String
    var Poster: String
    var Ratings: [Rating]
    var Metascore: String
    var imdbRating: String
    var imdbVotes: String
    var imdbID: String
    var `Type`: String
    var DVD: String?
    var BoxOffice: String?
    var totalSeasons:String?
    var Production: String?
    var Website: String?
    var Response: String
}
