//
//  SearchController.swift
//  onefimovies
//
//  Created by gHOST on 7/3/19.
//  Copyright © 2019 onefi. All rights reserved.
//

import UIKit
//search controller inheriting from UITableViewController and implementing UISearchBarDelegate
class SearchController: UITableViewController, UISearchBarDelegate {
    
    //variable declation
    let cellId = "SearchTableCell" //Cell id for table view
    // declaration and intiliazation of the list for found movies
    var foundMovieList = DataManager.sharedManager.movielistData
    // an index tracker for selected cell, used to pass the right movie detail object to detail view
    var selectedIndex = 0
    
    //override on view did load from UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        //set up for navigation bar
        setupnavigationbar()
        //set up for table view
        setupTableView()
    }
    
    // function to setup navigation bar
    func  setupnavigationbar(){
        //create and set UIsearchBar object
        let searchBar = UISearchBar()
        
        //customizations on the search bar
        searchBar.sizeToFit()
        searchBar.heightAnchor.constraint(equalToConstant: 45).isActive = true
        searchBar.placeholder = "Search for Movies"
        searchBar.becomeFirstResponder()
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        let textFieldInsideUISearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideUISearchBar?.font = textFieldInsideUISearchBar?.font?.withSize(14)
        let cancelBtn = searchBar.value(forKey: "cancelButton") as? UIButton
        cancelBtn?.titleLabel?.font = textFieldInsideUISearchBar?.font?.withSize(14)
        navigationItem.titleView = searchBar
        
        //hide backbutton on navigation item
        navigationItem.setHidesBackButton(true, animated:false);
        
    }
    
    //set up table view
    fileprivate func setupTableView() {
        //register table cell from nib
        let cellNib = UINib.init(nibName: cellId, bundle: Bundle.main)
        self.tableView.register(cellNib, forCellReuseIdentifier: cellId)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40
        tableView.tableFooterView = UIView()
        
    }
    
    //function on from search bar delegate
    //called on textdid change
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //get movie list from the datamanger singleton
        self.foundMovieList = DataManager.sharedManager.movielistData.filter({ $0.Title.contains(searchText) })
        //check for the found movie list count
        if self.foundMovieList.count <= 0{
            self.foundMovieList = DataManager.sharedManager.movielistData
        }
        self.tableView.reloadData() // reload table
    }
    
    //function on the search bar cancel button click event
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        //remove current view
        self.navigationController?.popViewController(animated: true)
    }
    
    //set number of section within table view
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //return number of table cell based on the size of found movie list
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.foundMovieList.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //set the selected index on the select event registered on the table cell
        self.selectedIndex = indexPath.row
        //perform segue to open details
        self.performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //creation table cell view
        let cellView = self.tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SearchTableCell
        //set table view model
        cellView.setModel(searchmodel: SearchViewModel(moviedata: self.foundMovieList[indexPath.row]))
        //return table cell view
        return cellView
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     //check if identifier matches
        if (segue.identifier == "showDetail") {
            //check if destination matched details controller
            if let vc = segue.destination as? DetailsController {
                //set data within detail controller
                vc.moviedata = self.foundMovieList[self.selectedIndex]
            }
        }
    }
    
}
