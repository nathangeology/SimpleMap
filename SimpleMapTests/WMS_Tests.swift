//
//  WMS_Tests.swift
//  SimpleMap
//
//  Created by Nathaniel Jones on 6/5/15.
//  Copyright (c) 2015 Nate Geo LLC. All rights reserved.
//

import UIKit
import XCTest

class WMS_Tests: XCTestCase, WMS_Server_Delegate{
    let serverURL = NSURL(string: "http://gstore.unm.edu/apps/rgis/datasets/8320ffc3-f0eb-4c3e-a22b-4b5599852ce9/services/ogc/wms?SERVICE=wms&REQUEST=GetCapabilities&VERSION=1.1.1")//NSURL(string:"http://services.azgs.az.gov/arcgis/services/aasggeothermal/CAWellHeaders/MapServer/WMSServer?request=GetCapabilities&service=WMS")
    //get map example: http://services.azgs.az.gov/arcgis/services/aasggeothermal/CAWellHeaders/MapServer/WMSServer?VERSION=1.3.0&REQUEST=GetMap&CRS=CRS:84&BBOX=-124.0000,33.000,-114.450790,41.00&WIDTH=360&HEIGHT=360&LAYERS=,Wellheader&STYLES=,&Symbolizer&EXCEPTIONS=application/vnd.ogc.se_xml&FORMAT=image/png&BGCOLOR=0xFFFFFF&TRANSPARENT=TRUE
    //NSURL(string:"http://www.openatlas.net/geoserver/ows?SERVICE=WMS&REQUEST=GetCapabilities")
    
   //
    var parser : NSXMLParser!
    var aSyncExpectation : XCTestExpectation!
    var testServer : WMS_Server!
    override func setUp() {
        super.setUp()
        print("prepping WMS test");
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    
    func testGetCapabilities() {
        print("Testing get capabilities call");
        print("Getting capabilities of test WMS server at: \(serverURL!)")
        let expectation = expectationWithDescription("GET \(serverURL!)")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(serverURL!) {(data, response, error) in
            //println(NSString(data: data, encoding: NSUTF8StringEncoding))
            XCTAssertNotNil(data, "data should not be nil")
            XCTAssertNil(error, "error should be nil")
            print("Got url data continuing!")
            //Write Data to file for test of XML parsing
            let bundle = NSBundle(forClass: self.classForCoder)
            let path = bundle.resourcePath!
            let dataPath = path.stringByAppendingString("/parseTest.xml")
            if data != nil {
                data!.writeToFile(dataPath, atomically: true) }
            //let xml = NSString(data: data, encoding: NSUTF8StringEncoding);
            //println("DATA: \(xml)")
            if let HTTPResponse = response as? NSHTTPURLResponse {
                //XCTAssertEqual(HTTPResponse.URL!.absoluteString!, self.serverURL!, "HTTP response URL should be equal to original URL")
                XCTAssertEqual(HTTPResponse.statusCode, 200, "HTTP response status code should be 200")
                XCTAssertEqual(HTTPResponse.MIMEType as String!, "application/xml", "HTTP response content type should be text/xml")
            } else {
                XCTFail("Response was not NSHTTPURLResponse")
            }
            //self.parser = NSXMLParser(data: data!)
           // self.parser.delegate = self
           // self.parser.parse()
            
            
            
            expectation.fulfill()
        }
        
        task!.resume()
        waitForExpectationsWithTimeout(task!.originalRequest!.timeoutInterval) { (error) in
            task!.cancel() }
    }
    /*func testResponseParsing() {
        print("Parse test not implemented");
        

        let bundle = NSBundle(forClass: self.classForCoder)
        let path = bundle.resourcePath!
        let dataPath = path.stringByAppendingString("/parseTest.xml")
        let data = NSData(contentsOfFile: dataPath);
        XCTAssertNotNil(data, "data should not be nil")
        self.parser = NSXMLParser(data: data!)
        self.parser.delegate = self
        self.parser.parse()
       // XCTAssert(true, "Not Implemented")
    }*/
    func testMakeNewWMS_Server() {
        self.aSyncExpectation = expectationWithDescription("GET \(serverURL!)")
        self.testServer = WMS_Server(serverURL: serverURL!)
        waitForExpectationsWithTimeout(10) { (error) in
            print("Test server request failed")
            XCTAssert(true)
        }
    }
    func testWMS_ParserBasic() {
        let testParser = WMS_Parser()
        let bundle = NSBundle(forClass: self.classForCoder)
        let path = bundle.resourcePath!
        let dataPath = path.stringByAppendingString("/parseTest.xml")
        let data = NSData(contentsOfFile: dataPath);
        XCTAssertNotNil(data, "data should not be nil")
        self.parser = NSXMLParser(data: data!)
        self.parser.delegate = testParser
        self.parser.parse()
        let crsData = testParser.parsedElements["CRS"]
        XCTAssertNotNil(crsData)
        XCTAssertEqual(crsData![0], "CRS:84")
        print(crsData![0])
        let westLongitude = testParser.parsedElements["westBoundLongitude"]
        XCTAssertNotNil(westLongitude)
        XCTAssertEqual(westLongitude![0], "-124.291532")
        print(westLongitude![0])
    }
    func returnedMapForBoundingBox(mapImage :UIImage, boundingBox : CGRect) {}
    func returnedFeatureDataForBoundingBox(featureData : NSData, boundingBox : CGRect) {}
    func serverIsReady() {
        //check server is ready to go
        XCTAssertEqual(testServer!.isReady, true, "Server should be ready! Major issue")
        XCTAssertEqual(testServer!.settings.boundingBox.origin, CGPoint(x: -124.291532, y: 41.976568), "Origin for the server does not equal test server settings")
        XCTAssertEqual(testServer!.settings.crs, .CRS_84, "Coordinate reference system is unknown!")
        XCTAssertEqual(testServer!.settings.imageFormat, .png, "Image format is incorrect")
        XCTAssertEqual(testServer!.settings.featureFormat, .text_xml, "Feature format is incorrect")
        self.aSyncExpectation.fulfill()
    }
        /*func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }*/

}
