//
//  CategoryViewController.swift
//  Taaref
//
//  Created by Bader Alrasheed on 9/17/14.
//  Copyright (c) 2014 Baims. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    
    var categoryID   : String!
    var categoryName : String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = self.categoryName
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
