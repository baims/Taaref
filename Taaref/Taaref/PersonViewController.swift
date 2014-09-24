//
//  PersonViewController.swift
//  Taaref
//
//  Created by Bader Alrasheed on 9/22/14.
//  Copyright (c) 2014 Baims. All rights reserved.
//

import UIKit

class PersonViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var profileImageView : UIImageView!
    @IBOutlet weak var headerImageView  : UIImageView!
    
    @IBOutlet weak var aboutTextView    : UITextView!
    
    @IBOutlet weak var nameLabel        : UILabel!
    @IBOutlet weak var usernameLabel    : UILabel!
    
    @IBOutlet weak var collectionView   : UICollectionView!
    
    @IBOutlet weak var segmentedControl : UISegmentedControl!
    
    // CONSTRAINTS
    @IBOutlet weak var constraintAboutTextView_height: NSLayoutConstraint!
    @IBOutlet weak var constraintHeaderImageView_height: NSLayoutConstraint!
    
    
    var username : String!
    var userID   : String!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = self.username
        
        self.usernameLabel.text = self.username
    }
    
    override func viewWillLayoutSubviews() {
        self.aboutTextView.sizeToFit()
        
        var sizeOfAboutTextView = (width: self.aboutTextView.frame.width, height: self.aboutTextView.frame.height)
        var heightOfModifiedAboutTextView = self.aboutTextView.sizeThatFits(CGSizeMake(sizeOfAboutTextView.width, CGFloat.max)).height
        self.constraintAboutTextView_height.constant   = heightOfModifiedAboutTextView+1
        self.constraintHeaderImageView_height.constant = 11+90+2+self.aboutTextView.frame.height+4
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        /*var newHeight = self.headerImageView.frame.height + (self.heightOfAboutTextView - self.aboutTextView.frame.size.height)
        self.constraintHeaderImageView_height.constant = newHeight
        
        println("\(self.heightOfAboutTextView) - \(self.aboutTextView.frame.size.height)")*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// UICollectionViewDataSource & Delegate

extension PersonViewController {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FeedCell", forIndexPath: indexPath) as FeedCollectionViewCell
        
        //cell.imageView = something
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        var widthOfCell : CGFloat = 0
        
        // Changing constraints depending on the device's screen size
        switch self.view.frame.height {
        case 480: // iPhone 4/4s
            widthOfCell = 88
        case 568: // iPhone 5/5s
            widthOfCell = 88
        case 667: // iPhone 6
            widthOfCell = 106
        case 736: // iPhone 6 Plus
            widthOfCell = 112
        default:
            widthOfCell = 112
        }
        
        return CGSizeMake(widthOfCell, widthOfCell)
    }
}