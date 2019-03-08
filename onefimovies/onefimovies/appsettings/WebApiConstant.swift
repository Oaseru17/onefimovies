//
//  WebApiConstant.swift
//  onefimovies
//
//  Created by gHOST on 6/3/19.
//  Copyright © 2019 onefi. All rights reserved.
//

enum serverState : Int {
    case notFound = 404
    case ok = 200
    case serverError = 500
    case jsonError = 401
}
//webapi contant for use on webservice
struct WebApiconstant {
    static let getRequest = "GET"
    static let postRequest = "POST"
    static let apikey = "1fe468b0"
    static let fetchurl = "http://www.omdbapi.com/"
}



