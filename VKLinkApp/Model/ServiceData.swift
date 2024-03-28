//
//  ServiceData.swift
//  VKLinkApp
//
//  Created by Alisher Saideshov on 28.03.2024.
//

import Foundation

struct ServiceData: Codable {
    let body: Body
    let status: Int
}

struct Body: Codable {
    let services: [Service]
}

struct Service: Codable {
    let name, description: String
    let link: String
    let iconURL: String

    enum CodingKeys: String, CodingKey {
        case name, description, link
        case iconURL = "icon_url"
    }
}
