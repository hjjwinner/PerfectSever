//
//  homeHandler.swift
//  MyAwesomeProject
//
//  Created by hjj on 16/11/26.
//
//

import Foundation


import PerfectHTTP
import PerfectMustache


func homeHandler(request: HTTPRequest, response:HTTPResponse) {
    response.setHeader(.contentType, value: "text/html")
    let d: [String:Any] = ["a":1, "b":0.1, "c": true, "d":[2, 4, 5, 7, 8]]
    
    do {
        try response.setBody(json: d)
    } catch{
        
    }
    
    
    print(request.cookies)
    print(request.path)
    
    response.appendBody(string: "<html><title>Hello, world!</title><body>Hello, world!</body></html>")
    response.completed()
}



func homePostHandler(request: HTTPRequest, _ response: HTTPResponse) {
    
    print("Uh oh, someone just called / using POST method!!!")
    response.completed()
    
}



func addUserHandler(request: HTTPRequest, _ response: HTTPResponse) {
    
    print("user-post")
    
    let firstName = request.param(name: "firstName", defaultValue: "")
    let lastName = request.param(name: "lastName", defaultValue: "")
    let emailAddress = request.param(name: "emailAddress", defaultValue: "")!

    guard !(firstName?.isEmpty)! else {
        response.appendBody(string: "First name is required!")
        response.completed()
        return
    }
    
    guard !(lastName?.isEmpty)! else {
        response.appendBody(string: "Last name is required!")
        response.completed()
        return
    }
    
    var returnMessage: String = "Oh hay! I see you have sent me a user called \(firstName!), \(lastName!)."
    if !(emailAddress.isEmpty) {
        returnMessage += " I also see \(emailAddress) as his/her email address"
    }
    
    
    var userObject:[String:AnyObject] = [:]
    var userObjectString: String = ""

    
    if let userFirstName = firstName {
        userObject["firstName"] = userFirstName as AnyObject?
    }
    
    if let userLastName = lastName {
        userObject["lastName"] = userLastName as AnyObject?
    }
    
//    if let userEmailAddress = emailAddress {
    if !emailAddress.isEmpty {
        userObject["emailAddress"] = emailAddress as AnyObject?

    }
//    }
    
    response.setHeader(.contentType, value: "application/json")
    
    response.status = HTTPResponseStatus.ok
    
    let errorPayload:[String:AnyObject] = [
        "error": "Could not set body!" as AnyObject
    ]
    
    var errorString :String = ""
    
    do {
        try errorString = errorPayload.jsonEncodedString()
        
    } catch  {
        
    }
    
    do{
        try response.setBody(json: userObject)
    }catch{
        response.status = HTTPResponseStatus.internalServerError
         response.appendBody(string: errorString)
    }
    
    
//    response.appendBody(string: returnMessage)
    
    response.completed()

}


func getUserDetails(request: HTTPRequest, _ response: HTTPResponse) {
    
    let params = request.urlVariables
    print(params)
    
    response.completed()

}


func listUsers(request: HTTPRequest, _ response: HTTPResponse) {
//    let parameters = request.queryParams
//    for keyval:(String, String) in parameters {
//        print("\(keyval.0) = \(keyval.1)")
//
//    }
    
    let milesToPoint = ["point1":120.0,"point2":50.0,"point3":70.0]
    let kmToPoint = milesToPoint.map { name,miles in miles * 1.6093 }
    print("\(kmToPoint)")
    
    let parameters = request.queryParams
    let set = parameters.map {$0}
    print("\(set)")
    
    
    response.addHeader(.contentType, value: "application/json")

    
    
    
    response.completed()
}

//文件上传
func uploadFiledHeader(request: HTTPRequest, _ response: HTTPResponse) {
    
    let webRoot = request.documentRoot
    
    mustacheRequest(request: request, response: response, handler: UploadHandler(), templatePath: webRoot + "/response.mustache")
    
    response.completed()
    
}




