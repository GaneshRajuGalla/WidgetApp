//
//  Enums.swift
//  WidgetApp
//
//  Created by Ganesh Raju Galla on 21/12/23.
//

import Foundation

// TODO: - HttpHeaderFields

enum HttpHeaderFields:String{
    case authentication = "Authorization"
    case acceptType = "accept"
    case contentType = "Content-Type"
}

// TODO: - ContentType

enum ContentType:String{
    case json = "Application/json"
}

// TODO: - HttpMethods

enum HttpMethods:String{
    case connect = "CONNECT"
    case delete = "DELETE"
    case get = "GET"
    case head = "HEAD"
    case options = "OPTIONS"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
    case trace = "TRACE"
}

// TODO: - Requestparams

enum Requestparams{
    case body(_ request:Encodable?)
    case query(_ request:Encodable?)
}
