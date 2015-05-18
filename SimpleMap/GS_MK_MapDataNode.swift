//
//  GS_MK_MapDataNode.swift
//  SimpleMap
//
//  Created by Nathaniel Jones on 5/17/15.
//  Copyright (c) 2015 Nate Geo LLC. All rights reserved.
//

import Foundation
import UIKit

class GS_MK_MapDataNode : GS_MK_MapDataSource  {
    var isRoot : Bool = false;
    var children : [GS_MK_MapDataNode] = []
    var parent : GS_MK_MapDataNode? = nil
    var origin : [Float] = [] //placeholder for a point, all children will reckon positions from this origin??
    var rootOrigin : [Float] = []  //position of node in root node space
    
    
    
    //TODO: render method is empty except to call renderers for children
    func renderToView(view : UIView, containedInRegion mapCoordinates : coordinateSystem) {}
    
}


class GS_MK_PointDataNode : GS_MK_MapDataNode {
    //TODO: Should set point size, color, etc
    
    //TODO: Need to render point at the given coordinates
    override func renderToView(view : UIView, containedInRegion mapCoordinates : coordinateSystem) {}
}