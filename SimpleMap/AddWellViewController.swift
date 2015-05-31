//
//  AddWellViewController.swift
//  SimpleMap
//
//  Created by Nathaniel Jones on 5/28/15.
//  Copyright (c) 2015 Nate Geo LLC. All rights reserved.
//

import UIKit

class AddWellViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Cancel(sender: AnyObject) {
        self.performSegueWithIdentifier("Cancel", sender: sender)
    }

    @IBAction func Done(sender: AnyObject) {
        self.performSegueWithIdentifier("Done", sender: sender)
    }
    override func performSegueWithIdentifier(identifier: String?, sender: AnyObject?) {
        if identifier! == "Cancel"{
            println("Cancel")
            self.dismissViewControllerAnimated(true, completion: nil)
        } else {
            println("DONE")
            self.dismissViewControllerAnimated(true, completion: nil)
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
