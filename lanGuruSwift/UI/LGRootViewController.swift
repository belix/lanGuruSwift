//
//  LGRootViewController.swift
//  lanGuruSwift
//
//  Created by Felix Belau on 23.10.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

import UIKit

class LGRootViewController: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if NSUserDefaults.standardUserDefaults().objectForKey("localUserID") != nil
        {
            performSegueWithIdentifier("skipLogin", sender: nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
