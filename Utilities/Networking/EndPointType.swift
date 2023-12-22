//
//  EndPointType.swift
//  WidgetApp
//
//  Created by Ganesh Raju Galla on 21/12/23.
//

import Foundation

enum EndPointType{
    case getPhotos
}

extension EndPointType:TargetType{
    
    // TODO: - baseUrl
    
    var baseUrl: String {
        return "https://jsonplaceholder.typicode.com/"
    }
    
    // TODO: - path
    
    var path: String {
        switch self {
        case .getPhotos:
            return "photos"
        }
    }
    
    // TODO: - method
    
    var method: HttpMethods {
        switch self {
        case .getPhotos:
                .get
        }
    }
    
    // TODO: - params
    
    var params: Requestparams {
        switch self {
        case .getPhotos:
            return .query(nil)
        }
    }
}
