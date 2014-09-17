//
//  HomeViewController.swift
//  Taaref
//
//  Created by Bader Alrasheed on 9/16/14.
//  Copyright (c) 2014 Baims. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    // CONSTRAINTS
    @IBOutlet weak var constraintLogoImageView_top: NSLayoutConstraint!
    @IBOutlet weak var constraintLogoImageView_height: NSLayoutConstraint!
    @IBOutlet weak var constraintTableView_bottom: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.tableView.scrollEnabled   = false
        self.tableView.backgroundColor = UIColor.clearColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = self.tableView.indexPathForSelectedRow() {
            self.tableView.deselectRowAtIndexPath(indexPath, animated: animated)
        }
    }
    
    override func viewDidLayoutSubviews() {
        // Changing constraints depending on the device's screen size
        switch self.view.frame.height {
        case 480: // iPhone 4/4s
            self.constraintLogoImageView_height.constant = 200
            self.constraintLogoImageView_top.constant = 20
        case 568: // iPhone 5/5s
            self.constraintLogoImageView_top.constant = 25
        case 667: // iPhone 6
            self.constraintLogoImageView_top.constant = 55
            self.constraintTableView_bottom.constant  = 40
        case 736: // iPhone 6 Plus
            self.constraintLogoImageView_top.constant = 75
            self.constraintTableView_bottom.constant  = 60
        default:
            break
        }
        
        // Making rounded corners for the logoImageView
        self.logoImageView.layer.cornerRadius = self.logoImageView.frame.width/2
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        println("memory warning!!!!!!!!")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "CategorySegue" {
            let vc   = segue.destinationViewController as CategoryViewController
            
            let indexPath = self.tableView.indexPathForSelectedRow()!
            var cell = self.tableView.cellForRowAtIndexPath(indexPath) as CategoryTableViewCell
            
            vc.categoryID   = cell.categoryID
            vc.categoryName = cell.categoryLabel.text
        }
        
    }
}


// UITableViewDelegate & UITableViewDataSource
extension HomeViewController {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CategoryCell", forIndexPath: indexPath) as CategoryTableViewCell
        
        // Everything you need to change in the cell, make it inside this if statement
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor            = UIColor.redColor()
            cell.categoryID                 = indexPath.row == 0 ? "designer" : "photographer"
            cell.categoryLabel.text         = indexPath.row == 0 ? "المصممين" : "المصورين"
            cell.arrowImage.backgroundColor = UIColor.whiteColor()
        }
        else {
            cell.backgroundColor = UIColor.clearColor()
            cell.selectionStyle  = .None
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
       return indexPath.row % 2 == 0 ? 60 : 38
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}