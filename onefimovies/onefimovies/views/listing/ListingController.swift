//
//  ListingController.swift
//  onefimovies
//
//  Created by gHOST on 6/3/19.
//  Copyright © 2019 onefi. All rights reserved.
//

import UIKit
import SkeletonView

//listing controller inheriting from UITableViewController and implementing SkeletonTableViewDataSource
//listing controller fetches data using quue of movies data

class ListingController: UITableViewController,SkeletonTableViewDataSource {
    
    //variable declation
    //Cell id for table view
    let cellId = "MovieTableCell"
    //variable to hold the movie request
    var movieFetchQueue = Queue<MovieRequestData>()
    //variable to hold data respinds
    var movieDetialList = [MovieRespondData]()
    // variable to hold selected index, useful when sending data to details view
    var selectedIndex = 0
    //variable to hold state of applicatoin
    var loading = true
   
    override func viewDidLoad() {
        super.viewDidLoad()
         //set up for table view
        setupTableView()
        //begining processing the list of input
        //input required can be found in seed/movieseeddata.txt
        processSeed()
        
    }
    
    //set up table view
    fileprivate func setupTableView() {
        //register table cell from nib
        let cellNib = UINib.init(nibName: cellId, bundle: Bundle.main)
        self.tableView.register(cellNib, forCellReuseIdentifier: cellId)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        tableView.tableFooterView = UIView()
        self.clearsSelectionOnViewWillAppear =  true
    }
    
    //func on search button click
    @IBAction func searchBtnAction(_ sender: Any) {
        //perform segue and show search controller
        self.performSegue(withIdentifier: "showSearch", sender: self)
    }
    
    //process seed function
    func processSeed(){
        //use seed manger and fetch string
        if let seedData = SeedManager.fetchString(){
            //convert string to movie request queue
            self.movieFetchQueue = SeedManager.converToQueue(seedData: seedData)
            // begin fetching data from server
            fetchData()
        }
    }
    
    //fetch data function
    func fetchData(){
        //delay fetch
        //basically adds flair and time to begin animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            //check if queue is empty
            if(!self.movieFetchQueue.isEmpty){
                //closure to fetch data, reurns code and repsonds data
                ListingWebController.fetchData(request: self.movieFetchQueue.dequeue()!) { (responds, code) in
                    //check if code is OK
                    if(code == serverState.ok){
                        //check if responds is not nul
                        if let value = responds {
                            //run on main thread
                            DispatchQueue.main.async {
                                //check applicatoin loading state
                                if self.loading {
                                    // change state
                                    self.loading = false
                                    //reload table
                                    self.tableView.reloadData()
                                    //add value to movie detail list
                                    self.movieDetialList.append(value)
                                    //begin update on table with animation
                                    self.tableView.beginUpdates()
                                    self.tableView.insertRows(at: [IndexPath(row: self.movieDetialList.count-1, section: 0)], with: .automatic)
                                    self.tableView.endUpdates()
                                    
                                    //in iphone landspace mode and ipad application the view is split
                                    // this app is meant to send data to the detail view
                                    if(UIDevice.current.orientation.isLandscape){
                                        self.selectedIndex = 0
                                        self.performSegue(withIdentifier: "showDetail", sender: self)
                                    }
                                }else{
                                    // add data to movielist
                                    self.movieDetialList.append(value)
                                    //begin table update
                                    self.tableView.beginUpdates()
                                    self.tableView.insertRows(at: [IndexPath(row: self.movieDetialList.count-1, section: 0)], with: .left)
                                    self.tableView.endUpdates()
                                }
                                //check if movie is empty
                                if !self.movieFetchQueue.isEmpty {
                                    //fetch the next movie data
                                    self.fetchData();
                                }else{
                                    //set the movie list fot data manager
                                    DataManager.sharedManager.movielistData = self.movieDetialList
                                }
                            }
                            
                        }
                    }
                    
                    
                }
            }
            
        }
        
    }
    
    //return number of section in view
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //check the state of application
        //return row count based on state and number of movie in array
        if(loading){
            return 5
        }
        return self.movieDetialList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //create movie table cell object
        let cellView = self.tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MovieTableCell
        //check app state
        if loading {
            //show skeleton loading if app is in loading state
            cellView.showloading()
        }else{
            //hide skeleton loading
            cellView.hideloading()
            //set data model
            cellView.setData(model: ListingViewModel(moviedata: self.movieDetialList[indexPath.row]))
        }
        //return view
        return cellView
    }
    
    //return height for table cell
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //set the table selected index
        self.selectedIndex = indexPath.row
        //perform seque
        self.performSegue(withIdentifier: "showDetail", sender: self)
        
    }
    
    //set sketelon cell
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return cellId
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //check if identifier matches
        if (segue.identifier == "showDetail") {
            //check if destination matched details controller
            if let vc = segue.destination as? DetailsController {
                //set data within detail controller
                vc.moviedata = self.movieDetialList[self.selectedIndex]
            }
        }
    }
    
    
    
    
}
