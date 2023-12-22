//
//  Photos.swift
//  WidgetApp
//
//  Created by Ganesh Raju Galla on 21/12/23.
//

import Foundation

// MARK: - Photos
struct Photos: Codable,Hashable {
    let albumID, id: Int?
    let title: String?
    let url, thumbnailURL: String?

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}
