//
//  RatingController.swift
//  onefimovies
//
//  Created by gHOST on 6/3/19.
//  Copyright © 2019 onefi. All rights reserved.
//

import UIKit
//rating controller inheriting from UITableViewController and implementing UISearchBarDelegate
//rating controller showing all rating details for a movie
class RatingController: UITableViewController {
    
    //variable declation
    //Cell id for table view
    let cellId = "RatingTableCell"
    //nullable variable holiding the list of rating objects
    var ratinglist:[Rating]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         //set up for table view
        setupTableView()
    }
    
    //set up table view
    fileprivate func setupTableView() {
        //register table cell from nib
        let cellNib = UINib.init(nibName: cellId, bundle: Bundle.main)
        self.tableView.register(cellNib, forCellReuseIdentifier: cellId)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.tableFooterView = UIView()
        
    }
    
    //set number of section within table view
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //return number of table cell based on the size of rating
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  ratinglist!.count
    }
    
    //return height of the table cell
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //creation of ratingtable cell object
        let cellView = self.tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RatingTableCell
        //set the model for the table view
        cellView.setModel(ratingmodel:RatingViewModel(ratingdata: self.ratinglist![indexPath.row]))
        //return cell view
        return cellView
    }
    
    
  
    
    
}
