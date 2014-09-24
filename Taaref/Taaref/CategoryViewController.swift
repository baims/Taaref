//
//  CategoryViewController.swift
//  Taaref
//
//  Created by Bader Alrasheed on 9/17/14.
//  Copyright (c) 2014 Baims. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Instgram's Access Token: To be used with every
    let instagramAccessToken = "14222720.e71636a.071cd0f1a1f9442d9ff0116c814ed496"
    
    var categoryID   : String!
    var categoryName : String!
    
    /* Variables where we save all the information we get from JSONs for a better access */
    var arrayOfJSON        = [AnyObject]()
    var dictionaryOfImages = [String : String]()
    
    
    var widthOfCell : CGFloat = 1
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.categoryName
        
        
        /*** Check if the user launched the app before or not && to have some information to display until everything is updated ***/
        if let array = NSUserDefaults.standardUserDefaults().arrayForKey("arrayOfJSON_ID=\(self.categoryID)") {
            self.arrayOfJSON = array
        }
        if let dictionary = NSUserDefaults.standardUserDefaults().dictionaryForKey("dictionaryOfImages_ID=\(self.categoryID)") as? [String:String] {
            self.dictionaryOfImages = dictionary
        }
        
        
        /*** Making a GET request to the website and the website returns JSON that will be used for adding persons to the Collection View ***/
        let JSONurl_String = "http://BaimsApps.com/Taaref/persons.php?id=\(self.categoryID)"
        let JSONurl        = NSURL(string: JSONurl_String)
        let JSONrequest    = NSURLRequest(URL: JSONurl)
        
        
        var operation = AFHTTPRequestOperation(request: JSONrequest)
        
        operation.responseSerializer = AFJSONResponseSerializer()
        
        operation.setCompletionBlockWithSuccess({ (operation, responseObject) -> Void in
            self.arrayOfJSON = responseObject as [AnyObject]
            
            NSUserDefaults.standardUserDefaults().setObject(self.arrayOfJSON, forKey: "arrayOfJSON_ID=\(self.categoryID)")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            self.fetchImageURLFromArrayAndSaveToNSUserDefaults(self.arrayOfJSON)
            
            self.collectionView.reloadData()
        }, failure: { (operation, error) -> Void in
            println(error)
        })
        
        operation.start()
    }
    
    /*** Get all the Profile Images and save them in a dictionary for a better access ***/
    func fetchImageURLFromArrayAndSaveToNSUserDefaults(array: [AnyObject]) {
        for i in 0..<self.arrayOfJSON.count {
            let dictionary = self.arrayOfJSON[i] as NSDictionary
            
            let userID = dictionary.objectForKey("userID") as String
            
            let JSONurl_String = "https://api.instagram.com/v1/users/\(userID)/?access_token=\(self.instagramAccessToken)"
            let JSONurl        = NSURL(string: JSONurl_String)
            let JSONrequest    = NSURLRequest(URL: JSONurl)
            
            
            var operation = AFHTTPRequestOperation(request: JSONrequest)
            
            operation.responseSerializer = AFJSONResponseSerializer()
            
            operation.setCompletionBlockWithSuccess({ (operation, responseObject) -> Void in
                let mainDictionary = responseObject as NSDictionary
                let dataDictionary = mainDictionary.objectForKey("data") as NSDictionary
                
                let imageURL = dataDictionary.objectForKey("profile_picture") as String
                let id       = dataDictionary.objectForKey("id") as String
                
                
                self.dictionaryOfImages[id] = imageURL
                
                
                NSUserDefaults.standardUserDefaults().setObject(self.dictionaryOfImages, forKey: "dictionaryOfImages_ID=\(self.categoryID)")
                NSUserDefaults.standardUserDefaults().synchronize()
                
                self.collectionView.reloadData()

                }, failure: { (operation, error) -> Void in
                    println(error)
            })
            
            operation.start()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PersonSegue" {
            let vc = segue.destinationViewController as PersonViewController
            
            let indexPaths = self.collectionView.indexPathsForSelectedItems() as [NSIndexPath]
            let cell = self.collectionView.cellForItemAtIndexPath(indexPaths[0]) as PersonCollectionViewCell
            
            vc.username = cell.nameLabel.text
            vc.userID   = cell.userID
        }
    }

}


// UICollectionViewDataSource & UICollectionViewDelegate
extension CategoryViewController {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayOfJSON.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PersonCell", forIndexPath: indexPath) as PersonCollectionViewCell
        
        /*** Check if the information exists before loading it to the collection view ***/
        if NSUserDefaults.standardUserDefaults().arrayForKey("arrayOfJSON_ID=\(self.categoryID)") != nil {
            
            let dictionary = self.arrayOfJSON[indexPath.item] as NSDictionary
            
            cell.nameLabel.text = dictionary.objectForKey("username") as? String
            cell.nameLabel.sizeToFit()
            
            cell.userID = dictionary.objectForKey("userID")! as String
            
            // making rounded corners and removing any background colors
            cell.imageView.layer.cornerRadius = self.widthOfCell/2-14
            cell.imageView.backgroundColor = UIColor.clearColor()
            
            /*** Check if the image URLs exist in the dictionary before we make anything and crash the app ***/
            if NSUserDefaults.standardUserDefaults().dictionaryForKey("dictionaryOfImages_ID=\(self.categoryID)") != nil {
                let userID = dictionary.objectForKey("userID") as? String
                
                if let imageURL = self.dictionaryOfImages[userID!] {
                    
                    let url      = NSURL(string: imageURL)
                    let request  = NSURLRequest(URL: url)
                    
                    
                    cell.imageView.setImageWithURLRequest(request, placeholderImage: nil, success: { (request, response, image) -> Void in
                        
                        cell.imageView.image = image
                        cell.imageView.layer.masksToBounds = true
                        }) { (request, response, error) -> Void in
                            println(error)
                    }
                }
            }
        }
        
        // updating constraints so everything will look GORGEOUS
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        // Changing constraints depending on the device's screen size
        switch self.view.frame.height {
        case 480: // iPhone 4/4s
            self.widthOfCell = 96
        case 568: // iPhone 5/5s
            self.widthOfCell = 96
        case 667: // iPhone 6
            self.widthOfCell = 114
        case 736: // iPhone 6 Plus
            self.widthOfCell = 120
        default:
            self.widthOfCell = 120
        }
        
        return CGSizeMake(self.widthOfCell, self.widthOfCell+4)
    }
}
