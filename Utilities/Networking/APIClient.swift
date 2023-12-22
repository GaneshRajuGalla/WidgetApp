//
//  APIClient.swift
//  WidgetApp
//
//  Created by Ganesh Raju Galla on 21/12/23.
//

import Foundation

class APIClient{
    
    // MARK: - Properties
    
    private static let decoder:JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    private static let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    private static let successrange:Range = 200..<300
    
    // MARK: - Methods
    
    static func sendRequest<T:Decodable>(endPoint:EndPointType) async throws -> T{
        let (data,response) = try await session.data(for: endPoint.asUrlRequest())
        let validData = try validat(data: data, response: response)
        return try decoder.decode(T.self, from: validData)
    }
    
    
    // Function to validate the statuc code
    static private func validat(data:Data,response:URLResponse) throws -> Data{
        guard let code = (response as? HTTPURLResponse)?.statusCode else {
            throw NSError(domain: "Invalid Response", code: 0)
        }
        
        if successrange.contains(code){
            return data
        }else{
            switch code{
            case 401:
                throw NSError(domain: "UnAuthorized", code: code)
            case 404:
                throw NSError(domain: "Not Found", code: code)
            default:
                throw NSError(domain: "UnExpectedError", code: code)
            }
        }
    }
}
