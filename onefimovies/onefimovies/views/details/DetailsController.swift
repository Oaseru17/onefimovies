//
//  DetailsController.swift
//  onefimovies
//
//  Created by gHOST on 6/3/19.
//  Copyright © 2019 onefi. All rights reserved.
//

import UIKit

class DetailsController: UITableViewController {
    //nillable variable for movie data
    var moviedata:MovieRespondData?
    
    //UIView component declaration
    @IBOutlet weak var viewAll: UILabel!
    @IBOutlet weak var DetailBackground: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var yearDuration: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var pgRating: UILabel!
    @IBOutlet weak var plot: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var rateTotal: UILabel!
    @IBOutlet weak var metaScore: UILabel!
    @IBOutlet weak var topRatingScore: UILabel!
    @IBOutlet weak var topRatingSource: UILabel!
    @IBOutlet weak var actors: UILabel!
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var writers: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var awards: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var dvd: UILabel!
    @IBOutlet weak var boxOffice: UILabel!
    @IBOutlet weak var totalSeason: UILabel!
    @IBOutlet weak var production: UILabel!
    @IBOutlet weak var website: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.clearsSelectionOnViewWillAppear =  true
        //set action on view
        setActions()
        //check if movie fata is null
        if(self.moviedata != nil){
            //set detail vie
            setHeaderViewBackground()
            setview()
        }
        
    }
    
    //open rating view
    @objc func openRating(){
        self.performSegue(withIdentifier: "showRating", sender: self)
    }
    //set action on view
    fileprivate func setActions(){
        //set tap gestire on view all lable
        self.viewAll.addTapGesture(tapNumber: 1, target: self, action: #selector(openRating))
    }
    
    
    func setview(){
        //set view component with required value from movie data
        let url = URL(string: self.moviedata!.Poster)
        self.posterImage.kf.setImage(with: url, options: .none, progressBlock: nil, completionHandler: { (image, error, cache, url) in
            if(image == nil){
                self.posterImage.image = UIImage(named:"errorposter.jpg")
            }
        })
        
        movieTitle.text = self.moviedata!.Title
        language.text = self.moviedata!.Language
        yearDuration.text = "\(self.moviedata!.Year) - \(self.moviedata!.Runtime) Mins"
        country.text = self.moviedata!.Country
        genre.text = self.moviedata!.Genre
        rating.text = "\(self.moviedata!.imdbRating) (\(self.moviedata!.imdbVotes))"
        pgRating.text = self.moviedata!.Rated
        
        plot.text = self.moviedata?.Plot
        
        rateLabel.text = self.moviedata!.imdbRating
        rateTotal.text = self.moviedata!.imdbVotes
        metaScore.text = self.moviedata!.Metascore
        
        if self.moviedata!.Ratings.count > 0 {
            topRatingScore.text = self.moviedata!.Ratings[0].Value
            topRatingSource.text = self.moviedata!.Ratings[0].Source
            self.viewAll.isHidden = false
        }
        
        self.actors.text = self.moviedata!.Actors
        self.director.text = self.moviedata!.Director
        self.writers.text = self.moviedata!.Writer
        self.releaseDate.text = self.moviedata!.Released
        if let value = self.moviedata!.BoxOffice{
            self.boxOffice.text = value
        }
        
        
        if let value = self.moviedata!.totalSeasons {
            self.totalSeason.text = value
        }
        
        
        if let value = self.moviedata!.Production {
            self.production.text = value
        }
        
        
        self.awards.text = self.moviedata!.Awards
        self.type.text = self.moviedata!.Type
        if let value = self.moviedata!.DVD {
            self.dvd.text = value
        }
        
        if let value = self.moviedata!.Website {
            self.website.text = value
        }
        
        //recall table redraw, due to dynamic table cell height
        tableView.layoutIfNeeded()
    }
    
    //set header view background
    func setHeaderViewBackground() {
        navigationItem.title = "\(self.moviedata!.Title) - \(self.moviedata!.Year)"
        DetailBackground.contentMode = .top
        DetailBackground.clipsToBounds = true
        
        let url = URL(string: self.moviedata!.Poster)
        
        DetailBackground.kf.setImage(with: url, options: .none, progressBlock: nil, completionHandler: { (image, error, cache, url) in
            if(image == nil){
                self.DetailBackground.image = UIImage(named:"errorposter.jpg")
            }else{
                self.DetailBackground.image = self.resizeImage(image, newWidth:  self.DetailBackground.frame.width)
                
            }
        })
        
        
        
    }
    
    //resize poster image for header view backgrounf
    func resizeImage(_ image: UIImage?, newWidth: CGFloat) -> UIImage? {
        guard let image = image else {
            return nil
        }
        
        let scale = (newWidth ) / (image.size.width)
        let newHeight = image.size.height * scale
        
        let newSize = CGSize(width: (newWidth + 60), height: (newHeight + 60))
        
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(origin: CGPoint(x:-10,y:-15), size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
    
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(self.moviedata == nil){
            return 0
        }
        return 15
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 300
        case 1:
            return (self.plot.bounds.height + 20)
        case 2:
            return 120
        case 3:
            if self.moviedata!.Ratings.count > 0 {
                return 85
            }else{
                return 0
            }
        case 4:
            return (self.actors.bounds.height + 40)
        case 5:
            return (self.director.bounds.height + 40)
        case 6:
            return (self.writers.bounds.height + 40)
        case 7:
            return (self.releaseDate.bounds.height + 40)
            
        case 8:
            return (self.awards.bounds.height + 40)
        case 9:
            return (self.type.bounds.height + 40)
        case 10:
            if self.moviedata!.DVD != nil{
                return (self.dvd.bounds.height + 40)
            }
            return 0
        case 11:
            if self.moviedata!.BoxOffice != nil{
                return (self.boxOffice.bounds.height + 40)
            }
            return 0
        case 12:
            if self.moviedata!.totalSeasons != nil{
                return (self.totalSeason.bounds.height + 40)
            }
            return 0
        case 13:
            if self.moviedata!.Production != nil{
                return (self.production.bounds.height + 40)
            }
            return 0
        case 14:
            if self.moviedata!.Website != nil{
                return (self.website.bounds.height + 100)
            }
            return 0
        default:
            return 80
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showRating") {
            if let vc = segue.destination as? RatingController {
                vc.ratinglist = self.moviedata!.Ratings
            }
        }
    }
    
}
