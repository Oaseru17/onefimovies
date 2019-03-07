//
//  ColourSetting.swift
//  onefimovies
//
//  Created by Precious Osaro on 6/3/19.
//  Copyright © 2019 onefi. All rights reserved.
//


import Foundation
import UIKit

//Colour extension
extension UIColor {
    // static variable to set the primary color through the application
    static let primaryColor = "9A101D"
    
    // function to convert a string to the UIcolor class
    static  func hexStringToUIColor (hex:String) -> UIColor {
        //trim string and make it upper cased
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        //check for # in string
        if (cString.hasPrefix("#")) {
            //if found remove
            cString.remove(at: cString.startIndex)
        }
        
        //fallback if colour is not up to 6
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        //convert string to UInt32
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        //return UIColor
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

