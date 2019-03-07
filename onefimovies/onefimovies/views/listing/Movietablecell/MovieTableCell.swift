//
//  MovieTableCell.swift
//  onefimovies
//
//  Created by gHOST on 6/3/19.
//  Copyright © 2019 onefi. All rights reserved.
//

import UIKit
import Kingfisher
//movie table cell class, inheriting from UITableViewCell
class MovieTableCell: UITableViewCell {
    //variable declaration for UIELements
    @IBOutlet weak var directedby: UILabel!
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var posterImg: UIImageView!
    
      // create a list view model with an observer on didset method
    var listViewModel:ListingViewModel!{
        didSet{
            //set the text for the UILabel
            director.text = listViewModel.director
            year.text = listViewModel.year
            title.text = listViewModel.title
            //create url from poster url
            let url = URL(string: listViewModel.posterurl)
            //set indicator for lazy loading image
            posterImg.kf.indicatorType = .activity
            //set image in image view
            posterImg.kf.setImage(with: url, options: .none, progressBlock: nil, completionHandler: { (image, error, cache, url) in
                //a fallback on image fetch
                if(image == nil){
                    self.posterImg?.image = UIImage(named:"errorposter.jpg")
                }
            })
            
            
        }
    }
    
    //set data view model
    func setData(model : ListingViewModel){
        self.listViewModel = model
    }
    
    //show loading animation using skeleton animation
    func showloading(){
        posterImg.showAnimatedGradientSkeleton()
        title.showAnimatedGradientSkeleton()
        year.showAnimatedGradientSkeleton()
        directedby.showAnimatedGradientSkeleton()
        director.showAnimatedGradientSkeleton()
    }
    
   //hide loading animation using skeleton animation
    func hideloading(){
        posterImg.hideSkeleton()
        title.hideSkeleton()
        year.hideSkeleton()
        directedby.hideSkeleton()
        director.hideSkeleton()
    }
    
}
