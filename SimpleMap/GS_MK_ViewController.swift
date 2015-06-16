//
//  GS_MK_ViewController.swift
//  SimpleMap
//
//  Created by Nathaniel Jones on 5/14/15.
//  Copyright (c) 2015 Nate Geo LLC. All rights reserved.
//

import UIKit
import CoreData
class GS_MK_ViewController: UIViewController, NSXMLParserDelegate {
    var managedContext : NSManagedObjectContext!
    var wells : [Well] = []
    var parser : NSXMLParser!
    var posts : NSMutableArray = []
    var elements : NSMutableDictionary!
    var title1 : String!
    var date : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        //let url = NSURL(string: "http://services.azgs.az.gov/ArcGIS/services/aasggeothermal/CAWellLogs/MapServer/WFSServer?request=GetCapabilities&service=WFS")//?version=1.3.0&request=GetCapabilities&service=WMS
        
        /*let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            //println(NSString(data: data, encoding: NSUTF8StringEncoding))
                        self.parser = NSXMLParser(data: data!)
            self.parser.delegate = self
            self.parser.parse()
            
            
            //Fetch well info
            
            
            //If none found, create sample dataset
            
        }
        
        task!.resume()*/
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addWell(sender: AnyObject) {
        
        print("Add a well!!")
    }
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        //println("Ending Element name: \(elementName) ")
    }
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String]) {
       // println("Starting Element Named: \(elementName)")
    }
    func parser(parser: NSXMLParser, foundCharacters string: String) {
       // println("stuff in element: \(string)")
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
