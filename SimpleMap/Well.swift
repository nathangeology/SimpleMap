//
//  Well.swift
//  SimpleMap
//
//  Created by Nathaniel Jones on 5/28/15.
//  Copyright (c) 2015 Nate Geo LLC. All rights reserved.
//

import Foundation
import CoreData

class Well: NSManagedObject {

    @NSManaged var location: AnyObject

}

@objc class  GS_MK_Location : NSCoding {
    var X,Y : Float?
    
    init(x : Float, y : Float) {
        X = x;
        Y = y;
    }
    required init(coder aDecoder: NSCoder) {
        X = aDecoder.decodeFloatForKey("X")
        Y = aDecoder.decodeFloatForKey("Y")
        
    }
    func encodeWithCoder(aCoder: NSCoder) {
        if (X == nil) || (Y == nil) {
            X = 0;
            Y = 0;
        }
        
        aCoder.encodeFloat(X!, forKey: "X")
        aCoder.encodeFloat(Y!, forKey: "Y")
    }
    
}