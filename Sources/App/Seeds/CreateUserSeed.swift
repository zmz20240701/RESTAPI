//
//  File.swift
//  RESTAPI
//
//  Created by 赵康 on 2024/9/30.
//

import Foundation
import Vapor
import Fluent
struct CreateUserSeed: AsyncMigration {
    func prepare(on database: any Database) async throws {
        let admin = UserModel()
        admin.username = "赵康"
        admin.email = "zmz231126@gmail.com"
        admin.password = try Bcrypt.hash("000")
        admin.role = RoleEum.admin.rawValue
        admin.createAt = Date()
        admin.updateAt = Date()
        
        try await admin.create(on: database)
    }
    
    func revert(on database: any Database) async throws {
        try await UserModel.query(on: database).delete()
    }
}
