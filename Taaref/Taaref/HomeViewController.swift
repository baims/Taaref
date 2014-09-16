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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.scrollEnabled = false
    }
    
    override func viewDidLayoutSubviews() {
        self.logoImageView.layer.cornerRadius = self.logoImageView.frame.width/2
        
        // size @2x: 242x242
        // size @3x:
        println(self.logoImageView.frame.width)
        
        
        self.tableView.backgroundColor = UIColor.clearColor()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let cell = tableView.dequeueReusableCellWithIdentifier("PersonsSegue", forIndexPath: indexPath) as CategoriesTableViewCell
        
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor.redColor()
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
       return indexPath.row % 2 == 0 ? 70 : 54
    }
}