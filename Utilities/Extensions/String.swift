//
//  String.swift
//  WidgetApp
//
//  Created by Ganesh Raju Galla on 21/12/23.
//

import Foundation

extension String{
    
    public func asUrl() throws -> URL{
        guard let url = URL(string: self) else {
            throw NSError(domain: "Invalid URL", code: 0)
        }
        return url
    }
}
