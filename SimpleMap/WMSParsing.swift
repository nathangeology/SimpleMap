//
//  WMSParsing.swift
//  SimpleMap
//
//  Created by Nathaniel Jones on 6/7/15.
//  Copyright (c) 2015 Nate Geo LLC. All rights reserved.
//

import Foundation
import UIKit
protocol WMS_Server_Delegate {
    func returnedMapForBoundingBox(mapImage :UIImage, boundingBox : CGRect)
    func returnedFeatureDataForBoundingBox(featureData : NSData, boundingBox : CGRect)
    func serverIsReady()
    
}
protocol WMS_Server_DataSource {
    var serverURL : NSURL? {set get}
    var settings : WMS_Settings {set get}
    func getMapForBoundingBox(boundingBox : CGRect) throws -> ()
    func getFeaturesForBoundingBox(boundingBox : CGRect) throws -> ()
    func coordinateSystemIsAvailable(crs : CRS) -> Bool
    func imageTypeIsAvailable(image : ImageFormats) -> Bool
    func featureFormatIsAvailable(featureFormat : WMS_FeatureFormats) -> Bool
}
struct WMS_Settings {
    var featureFormat : WMS_FeatureFormats
    var crs : CRS //use 4326 as default
    var imageFormat : ImageFormats
    var boundingBox : CGRect
}
enum WMS_FeatureFormats {
    case text_xml //default supported
    case unknown
}
enum CRS {
    case ESPG_4236
    case CRS_84
    case unknownCRS
}
enum ImageFormats {

/*:  # supported formats for images
Tagged Image File Format (TIFF)
.tiff, .tif
Joint Photographic Experts Group (JPEG)
.jpg, .jpeg
Graphic Interchange Format (GIF)
.gif
Portable Network Graphic (PNG)
.png
Windows Bitmap Format (DIB)
.bmp,*/
    case tiff
    case tif
    case jpg
    case jpeg
    case gif
    case png //default
    case bmp
    case unknown
}

struct WMS_Server : WMS_Server_DataSource{
    var serverURL : NSURL? {
        set (newURL) {
            //TODO: implement this, set the newURL to the URL and update the settings (this part needs more methods for the struct)
            self.serverURL = newURL
            self.settings = WMS_Settings(featureFormat: .unknown, crs: .unknownCRS, imageFormat: .unknown, boundingBox: CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0))
            let task = NSURLSession.sharedSession().dataTaskWithURL(serverURL!) {(data, response, error) in
                    let parserWMSDelegate = WMS_Parser()
                    let parser = NSXMLParser(data: data!)
                    parser.delegate = parserWMSDelegate
                    parser.parse()
                    let formatList = parserWMSDelegate.parsedElements["Format"]
                    let crsList = parserWMSDelegate.parsedElements["CRS"]
                    let westBound = parserWMSDelegate.parsedElements["westBoundLongitude"]
                    let eastBound = parserWMSDelegate.parsedElements["eastBoundLongitude"]
                    let southBound = parserWMSDelegate.parsedElements["southBoundLatitude"]
                    let northBound = parserWMSDelegate.parsedElements["northBoundLatitude"]
                if (westBound != nil) {
                    let west = westBound![0] as NSString
                    let east = eastBound![0] as NSString
                    let north = northBound![0] as NSString
                    let south = southBound![0] as NSString

                    self.settings.boundingBox = CGRect(origin: CGPoint(x:CGFloat(west.floatValue), y: CGFloat(south.floatValue)), size: CGSize(width: CGFloat(east.floatValue - west.floatValue), height: CGFloat(north.floatValue - south.floatValue)))
                }
                if crsList != nil {
                   
                    for crs in crsList!{
                        if crs == "CRS:84" {
                            self.settings.crs = .CRS_84
                            
                            break;
                        }
                        
                    }
                }
                if formatList != nil {
                    
                    for format in formatList! {
                        if format == "image/png" {
                            
                            self.settings.imageFormat = .png
                        }
                        else if format == "application/xml" {
                            
                            self.settings.featureFormat = .text_xml
                        }
                    
                    }
                    
                }
                self.isReady = true;
                }
            task?.resume()
            
        }
        get {
            return self.serverURL;
        }
    }
    var settings : WMS_Settings {
        set (newSettings) {
             //TODO: implement this
        }
        get {
            return self.settings
        }
    }
    var isReady : Bool = false {
        
        didSet {
            if self.isReady {
                delegate.serverIsReady() }
        }
    
    }
    var delegate : WMS_Server_Delegate!
    init(serverURL : NSURL) {
        self.serverURL = serverURL
    }
    func getMapForBoundingBox(boundingBox : CGRect) throws -> () {} //TODO: implement this
    func getFeaturesForBoundingBox(boundingBox : CGRect) throws -> () {} //TODO: implement this
    func coordinateSystemIsAvailable(crs : CRS) -> Bool {return false} //TODO: implement this
    func imageTypeIsAvailable(image : ImageFormats) -> Bool {return false} //TODO: implement this
    func featureFormatIsAvailable(featureFormat : WMS_FeatureFormats) -> Bool {return false} //TODO: implement this
  
    

}
class WMS_Parser : NSObject, NSXMLParserDelegate {
    var elementStack : [String] = []
    var parsedElements = [String : [String]] ()
    @objc func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
         elementStack.removeLast()
        print(elementName)
    }
    @objc func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String]) {
        elementStack.append(elementName)
         print(elementName)
    }
    @objc func parser(parser: NSXMLParser, foundCharacters string: String) {
        print("stuff in element: \(string)")
        let tempData = parsedElements[elementStack.last!]
        if tempData != nil {
            var tempData2 = tempData!
            tempData2.append(string)
            parsedElements[elementStack.last!] = tempData2;
        } else {
            parsedElements[elementStack.last!] = [string];
        }
    }

}
