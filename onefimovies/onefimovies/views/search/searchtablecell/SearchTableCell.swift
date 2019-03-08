//
//  SearchViewCell.swift
//  onefimovies
//
//  Created by gHOST on 7/3/19.
//  Copyright © 2019 onefi. All rights reserved.
//

import UIKit
//search table cell class, inheriting from UITableViewCell
class SearchTableCell: UITableViewCell {
   // create a search view model with an observer on didset method
    var searchViewModel:SearchViewModel!{
        didSet{
            //set the text for the UILabel
            title.text = "\(searchViewModel.title) - \(searchViewModel.year)"
        }
    }
    
    //variable declaration for UIELements
    @IBOutlet weak var title: UILabel!
    
    //set the view model function
    func setModel(searchmodel:SearchViewModel){
        self.searchViewModel = searchmodel
}

}
