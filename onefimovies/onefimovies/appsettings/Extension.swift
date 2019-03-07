//
//  Extension.swift
//  onefimovies
//
//  Created by Precious Osaro on 6/3/19.
//  Copyright © 2019 onefi. All rights reserved.
//


import UIKit

//an extension on uiview
extension UIView {
    //add a tap gesture fuction to ui view
    func addTapGesture(tapNumber: Int, target: Any, action: Selector) {
        //create gesture recognizer
        let tap = UITapGestureRecognizer(target: target, action: action)
        //set number of count
        tap.numberOfTapsRequired = tapNumber
        //add gesture to view
        addGestureRecognizer(tap)
        // set the user interaction
        isUserInteractionEnabled = true
    }
}

//an extension on the string
extension String {
    //function to trim string
    func trim() -> String {
        //trim the string of all white spaces and new line
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    //function to retuen boolean for string value
    var bool: Bool? {
        //return lowercase value for string
        //run a switch case to return boolean
        switch self.lowercased() {
        case "true", "t", "yes", "y", "1":
            return true
        case "false", "f", "no", "n", "0":
            return false
        default:
            return nil
        }
    }
}

//an extension on viewcontroller
extension UIViewController {
    //function to display an alert
    func displayAlert(header:String,detail:String){
        //create alert object
        let alert = UIAlertController(title: header, message: detail, preferredStyle: .alert)
        //add ok button
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        //present on view
        self.present(alert, animated: true)
   }
}





