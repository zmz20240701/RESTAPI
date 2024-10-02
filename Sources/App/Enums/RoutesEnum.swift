//
//  File.swift
//  RESTAPI
//
//  Created by 赵康 on 2024/10/1.
//

import Foundation

enum RoutesEnum: String, Equatable {
    case profile
    case login
    case register
    case update
    case delete
    case guides
    case courses
    case sessions
    case articles
    case search
}

enum RouteParameters: String, Equatable {
    case slug = ":slug"
    case id = ":id"
    case status = ":status"
    case query = ":query"
    case article = ":articleSlug"
}
