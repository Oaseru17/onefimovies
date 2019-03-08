//
//  RatingTableCell.swift
//  onefimovies
//
//  Created by gHOST on 6/3/19.
//  Copyright © 2019 onefi. All rights reserved.
//

import UIKit
//rating table cell class, inheriting from UITableViewCell
class RatingTableCell: UITableViewCell {
     // create a rating view model with an observer on didset method
    var ratingViewModel:RatingViewModel!{
        didSet{
               //set the text for the UILabel
            value.text = ratingViewModel.value
           source.text = ratingViewModel.source
        }
    }
    
     //variable declaration for UIELements
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var source: UILabel!
    
    //set the view model function
    func setModel(ratingmodel:RatingViewModel){
        self.ratingViewModel = ratingmodel
    }
    
}
