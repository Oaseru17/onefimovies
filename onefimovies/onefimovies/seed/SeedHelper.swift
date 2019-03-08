//
//  SeedHelper.swift
//  onefimovies
//
//  Created by gHOST on 6/3/19.
//  Copyright © 2019 onefi. All rights reserved.
//
import Foundation

//seed class
class SeedManager{
    
    //declarations variable name
    private  static let filename = "movieseeddata"
    private  static let file_ext = "txt"
    
    //read file as string
    public static func fetchString()-> String? {
        //locate and load file from resource
        if let url = Bundle.main.url(forResource: filename, withExtension: file_ext) {
            do { //a do and catch to convert the content to string
                let text = try String(contentsOf: url, encoding: .utf8)
                return text // return the value
            } catch {
                return nil
            }
        }
        return nil
    }
    
    //function to convert the string to a queue of movie list waiting to fetch data from server
    public static func converToQueue(seedData : String)->Queue<MovieRequestData>{
        //clean the string and convert responds to array
        let seedArray = cleanString(dirtyString: seedData).components(separatedBy: ["\n"])
        // declare an empty queue
        var queueData = Queue<MovieRequestData>()
        //loop through the seedArray
        for var movieLine in seedArray{
            movieLine = movieLine.trim() // trim array
            if !movieLine.isEmpty { // fall back if string is empty
                // create string to arrat
                let movieData = movieLine.components(separatedBy: ["(",")"])
                if movieData.count == 3 { // check to make sure proper size is reached
                    //create a movie request object
                    //add object to queue
                    queueData.enqueue(MovieRequestData(name: movieData[0],year: movieData[1]))
                }
            }
        }
        //return queue
        return queueData
    }
    
    //function to clean string
    public static func cleanString(dirtyString: String)->String{
        //remove carriage return
        var cleanString = dirtyString.replacingOccurrences(of: "\r", with: "\n")
        //remove doble new line
        cleanString = cleanString.replacingOccurrences(of: "\n\n", with: "\n")
        //return clean string
        return cleanString
    }
}
