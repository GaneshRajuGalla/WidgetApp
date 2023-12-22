//
//  TargetType.swift
//  WidgetApp
//
//  Created by Ganesh Raju Galla on 21/12/23.
//

import Foundation

protocol TargetType{
    var baseUrl :String {get}
    var path :String {get}
    var method :HttpMethods {get}
    var params: Requestparams {get}
}

extension TargetType{
    
    /// Functyion to create URLRequest
    func asUrlRequest() throws -> URLRequest{
        let url = try baseUrl.asUrl()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HttpHeaderFields.contentType.rawValue)
        
        switch params{
        case .body(let request):
            let params = try request?.toDictionary()
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params)
            
        case .query(let request):
            let params = try request?.toDictionary()
            let queryItems = params?.compactMap({URLQueryItem(name: $0.key, value: "\($0.value)")})
            var urlComponent = URLComponents(string: url.appendingPathComponent(path).absoluteString)
            urlComponent?.queryItems = queryItems
            urlRequest.url = urlComponent?.url
        }
        return urlRequest
    }
}
