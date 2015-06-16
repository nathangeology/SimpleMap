//
//  OGC_HTTP.swift
//  SimpleMap
//
//  Created by Nathaniel Jones on 6/13/15.
//  Copyright © 2015 Nate Geo LLC. All rights reserved.
//

import Foundation


struct URLString {
    var baseServerString : String = ""
    var keys : [String] = []
}

protocol httpRequest {
    func makeHTTPRequest(urlString : URLString)
    
}