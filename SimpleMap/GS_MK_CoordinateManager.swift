//
//  GS_MK_CoordinateManager.swift
//  SimpleMap
//
//  Created by Nathaniel Jones on 5/17/15.
//  Copyright (c) 2015 Nate Geo LLC. All rights reserved.
//

import Foundation
import UIKit
//Data Structures
/*
struct GS_MK_Point : pointCoordinate {
    var x,y : CGFloat
}
struct GS_MK_Size : sizeCoordinate{
    var width, height : CGFloat
}
struct GS_MK_Region {
    var origin : GS_MK_Point
    var size : GS_MK_Size
}



//MARK: Coordinate System Protocols
protocol coordinateSystem {
    var origin : pointCoordinate {get set}
    var size : sizeCoordinate {get set}
}
protocol pointCoordinate {
    var x : CGFloat {get set}
    var y : CGFloat {get set}
}
protocol sizeCoordinate {
    var width : CGFloat {get set}
    var height : CGFloat {get set}
}
protocol updateRelatedCoordinateSystem {
    func updateCoordinateSystem( newCoordinates : coordinateSystem)
}
//MARK: CGRECT, CGPOINT, & CGSIZE extensions
extension CGSize : sizeCoordinate {
    var width : CGFloat {
        get{
            return self.width
        }
        set(newWidth) {
            self.width = newWidth
        }
    }
    var height : CGFloat {
        get{
            return self.height
        }
        set(newWidth) {
            self.height = newWidth
        }
    }
}
extension CGPoint : pointCoordinate {
    var x : CGFloat {
        get{
            return self.x
        }
        set(newX) {
            self.x = newX
        }
    }
    var y : CGFloat {
        get {
            return self.y
        }
        set (newY) {
            self.y = newY
        }
    }
}
extension CGRect : coordinateSystem {
    var size : sizeCoordinate {
        get {
            return self.size
        }
        set(newSize) {
            self.size = newSize;
        }
    }
    var origin : pointCoordinate {
        get {
            return self.origin
        }
        set (newOrigin) {
            self.origin = newOrigin;
        }
    }
}

class GS_MK_CoodinateManager : updateRelatedCoordinateSystem{
    var screenRegion : CGRect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 0, height: 0))
    var mapRegion : GS_MK_Region = GS_MK_Region(origin: GS_MK_Point(x: 0, y: 0), size: GS_MK_Size(width: 0, height: 0))
    //MAP coordinate system property?
    
    func updateCoordinateSystem(newCoordinates: coordinateSystem) {
        //TODO: Setup update of map coordinates from a change in screen coordinates
    }
    
}*/