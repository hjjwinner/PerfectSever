//
//  AppRoutes.swift
//  MyAwesomeProject
//
//  Created by hjj on 16/11/26.
//
//

import Foundation


import PerfectHTTP


func setupAppRoutes() -> Routes {
    var routes = Routes()
    routes.add(method: .get, uri: "/", handler: homeHandler)
    routes.add(method: .post, uri: "/home", handler: homePostHandler)

    routes.add(method: .post, uri: "/users", handler: addUserHandler)
    
    routes.add(method: .get, uri: "/users/123", handler: getUserDetails)

    routes.add(method: .get, uri: "/users", handler: listUsers)

    routes.add(method: .post, uri: "/upload", handler: uploadFiledHeader)


    return routes
}




