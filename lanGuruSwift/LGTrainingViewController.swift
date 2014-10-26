//
//  TrainingViewController.swift
//  lanGuruSwift
//
//  Created by Felix Belau on 20.10.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

import UIKit

class LGTrainingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "pushGame"{
            var destinationViewController : LGGamingViewController = segue.destinationViewController as LGGamingViewController
            destinationViewController.hidesBottomBarWhenPushed = true;
        }
    
    }
    

}
