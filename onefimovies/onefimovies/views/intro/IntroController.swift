//
//  IntroController.swift
//  onefimovies
//
//  Created by gHOST on 6/3/19.
//  Copyright © 2019 onefi. All rights reserved.
//

import UIKit

//introduction controller
class IntroController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
 
    //UIComponent component declaration
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var introcollectionview: UICollectionView!
    @IBOutlet weak var introstagelayout: UICollectionViewFlowLayout!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var logo: UIImageView!
    
    //shape declaratioin
    var circle = UIView(
        frame: CGRect(x: 0.0, y: 0.0, width: 1, height: 1
    ))
    
    //animaton variable declaration
    let translate = CGAffineTransform(translationX: 100, y: 100)
    let scale = CGAffineTransform(scaleX: 0.1, y: 0.1)
    let bigscale = CGAffineTransform(scaleX: 1, y: 1)
    
    //current index  trackerfor swipe
    var currentindex = 0;
    
    //into 2d array to hold intro information
    var introArray = [
        [
            "header":"Welcome to the home of movies",
            "feeds": "we offer you the largest collection of online movies and information in Africa"
        ],
        [
            "header":"Find all the information",
            "feeds": "Browse through our detail collection of information"
        ],
        [
            "header":"Get paid for the infromation provide",
            "feeds": "Provide data for movies and get paid within minutes"
        ]
        
        
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set indetifier for UI testing
        self.view.accessibilityIdentifier = "introView"
        self.nextBtn.accessibilityIdentifier = "nextBtn"
        //set background for view
        setbackgroundflip()
        //check intro has been conducted
        if(databasehelper.checkShownintro()){
            showhomenointro()
        }else{
            hideintrobackground()
        }
       
       //set up intro swipe
        setupintro()
        self.previousBtn.isHidden = true
        
        //set action on labels
        self.nextBtn.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        self.previousBtn.addTarget(self, action: #selector(handlePrevious), for: .touchUpInside)
    }
    
    //set up into stage
    private func setupintro(){
        introstagelayout.minimumLineSpacing = 0
        introstagelayout.scrollDirection  = .horizontal
        introstagelayout.itemSize = CGSize(width:self.view.bounds.width,height:(self.view.bounds.height ))
        introcollectionview.isPagingEnabled = true
    }
    
    // set the circular cover on view
    private func setbackgroundflip(){
        var circleDimension = self.view.bounds.height * 4
        let circleRadius = self.view.bounds.height * 2
        if UIApplication.shared.statusBarOrientation.isLandscape{
            circleDimension = self.view.bounds.width * 4
           
        }
        self.circle = UIView(
            frame: CGRect(x: 0.0, y: 0.0, width: circleDimension, height: circleDimension
        ))
        self.circle.center = CGPoint(x: 0, y: 0);
        self.circle.backgroundColor = UIColor.hexStringToUIColor(hex: UIColor.primaryColor)
        self.circle.layer.cornerRadius = circleRadius
        self.view.addSubview(circle)
        self.view.bringSubviewToFront(self.logo)
    }
    
    //move to central withput introuduction
   
    func showhomenointro(){
        
        //do animation to hide background
        UIView.animate(withDuration: 0.8, delay: 1, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {
        }, completion: { finished in
            self.opencentral()
        })
    }
    
    
    func hideintrobackground(){
        //do animation to hide background
        UIView.animate(withDuration: 2, delay: 5, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {
            self.circle.transform = self.scale
            self.view.backgroundColor = UIColor.white
            self.logo.alpha = 0
           
        }, completion: { finished in
            self.logo.isHidden = true
        })
    }
    
    //handle next click
    @objc private func handleNext(){
    
        currentindex = (currentindex + 1)
        
        if(currentindex >= 2){
            currentindex = 2
            if(nextBtn.titleLabel!.text == "Finish"){
                self.logo.isHidden = false
                UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {
                    self.circle.transform = self.bigscale
                    self.logo.alpha = 1
                }, completion: { finished in
                    databasehelper.finishedintro()
                    self.cleanimage()
                    self.opencentral()
                    
                })
                
            }
            
            nextBtn.setTitle("Finish", for: .normal)
            
        }else{
            nextBtn.setTitle("Next", for: .normal)
        }
        
        if(currentindex <= 0){
            currentindex = 0
            previousBtn.isHidden = true
        }else{
            previousBtn.isHidden = false
        }
        
        let indexpath = IndexPath(item :  currentindex, section:0);
        self.pageControl.currentPage = currentindex
       self.introcollectionview.scrollToItem(at: indexpath, at: .centeredHorizontally, animated: true)
    }
    
    
    //handle previous
    @objc private func handlePrevious(){
     
        currentindex = (currentindex - 1)
        if(currentindex <= 0){
            currentindex = 0
            self.previousBtn.isHidden = true
        }else{
            self.previousBtn.isHidden = false
        }
        
        if(currentindex >= 2){
            currentindex = 2
            nextBtn.setTitle("Finish", for: .normal)
        }else{
            nextBtn.setTitle("Next", for: .normal)
        }
        pageControl.currentPage = currentindex;
        let indexpath = IndexPath(item :  currentindex, section:0);
        //   pageC.currentPage = pageC.currentPage + 1
       self.introcollectionview.scrollToItem(at: indexpath, at: .centeredHorizontally, animated: true)
    }
    
    //onscroll to detect swipe
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let w = scrollView.bounds.size.width
        let currentPage = Int(ceil(x/w))
        currentindex = currentPage
        pageControl.currentPage = currentPage
        
        if(currentindex <= 0){
            currentindex = 0
            self.previousBtn.isHidden = true
        }else{
            self.previousBtn.isHidden = false
        }
        
        if(currentindex >= 2){
            currentindex = 2
            nextBtn.setTitle("Finish", for: .normal)
        }else{
            nextBtn.setTitle("Next", for: .normal)
        }
    }
    
    //return collection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return introArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        //return collection size based on view
        return CGSize(width: self.view.bounds.width, height: (self.view.bounds.height) )
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //creation if cell view
        //set cell component
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Introcell", for: indexPath)
        let labelheader: UILabel? = cell.contentView.viewWithTag(2) as? UILabel
        let labeldesc: UILabel? = cell.contentView.viewWithTag(3) as? UILabel
        labelheader?.text = (introArray[indexPath.item]["header"])
        labeldesc?.text = (introArray[indexPath.item]["feeds"])
        return cell
        
    }
    
  //redraw stage
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        redrawcollection()
    }

    //on orientation change redraw collection
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        redrawcollection()
    }
    
    //redraw collection
    private func redrawcollection(){
        introstagelayout.itemSize = CGSize(width:self.view.bounds.width,height:(self.view.bounds.height ))
        introcollectionview.collectionViewLayout.invalidateLayout()
    }
    
    //a simple memory manangement
    override func didReceiveMemoryWarning() {
     cleanimage()
    }
    
    //clean images
    func cleanimage(){
        self.logo = nil
        self.background = nil
     
    }
    
    //show central view
    func opencentral(){
        self.cleanimage()
         self.performSegue(withIdentifier: "showCentral", sender: self)
    }
}
