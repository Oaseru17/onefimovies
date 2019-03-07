//
//  databasehelper.swift
//  onefimovies
//
//  Created by gHOST on 6/3/19.
//  Copyright © 2019 onefi. All rights reserved.
//
import UIKit

//struct to hold kets
struct databasekeys {
    static let introkey = "onefiintroductionkey"
}

//database helper class
class databasehelper {
    
    //reset key, this is useful during UI testing
    public static func reset(){
        //get the user default
        let defaults = UserDefaults.standard
        //remove the object from user default
        defaults.removeObject(forKey: databasekeys.introkey)
        
    }
    
    // function to check if the user has already gone through the intro
    public static func checkShownintro()  -> Bool{
        //get the user default
        let defaults = UserDefaults.standard
        //return the key value
        return defaults.bool(forKey: databasekeys.introkey)
        
    }
    
    //function to confirm user has already performed the intro session
    public static func finishedintro(){
        //get the user default
        let defaults = UserDefaults.standard
        //set object as true
        defaults.set(true, forKey: databasekeys.introkey)
    }
}
