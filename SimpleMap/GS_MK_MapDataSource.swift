//
//  GS_MK_MapDataSource.swift
//  SimpleMap
//
//  Created by Nathaniel Jones on 5/14/15.
//  Copyright (c) 2015 Nate Geo LLC. All rights reserved.
//

import Foundation
import UIKit

protocol GS_MK_MapDataSource {
    func renderToView(view : UIView, containedInRegion mapCoordinates : coordinateSystem); //[Float] is placeholder, may need to have view conform to protocol too
}



//MapDataNode
/*
-can be the 'root' node
-child objects contain drawable data
-can render data to a view within given coordinates
-can have parents/children if not the root node
- will have subtypes like "points" or "line"
*/