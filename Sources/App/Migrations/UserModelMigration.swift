import Foundation
import Fluent
import Vapor

struct UserModelMigration: AsyncMigration {
    let schema: String = UserModel.schema
    let keys: UserModel.FieldKeys.Type = UserModel.FieldKeys.self

    func prepare(on database: Database) async throws {
        try await database.schema(schema)
            .id()
            .field(keys.name, .string)
            .field(keys.lastname, .string)
            .field(keys.username, .string)
            .field(keys.password, .string)
            .field(keys.email, .string)
            .field(keys.city, .string)
            .field(keys.country, .string)
            .field(keys.address, .string)
            .field(keys.postalcode, .string)
            .field(keys.role, .string)
            .field(keys.subscriptionIsActiveTill, .datetime)
            .field(keys.myCourse, .array(of: .uuid))
            .field(keys.completedCourse, .array(of: .uuid))
            .field(keys.bio, .string)
            .field(keys.createdAt, .datetime)
            .field(keys.updateAt, .datetime)
            .field(keys.userImage, .string)
            .unique(on: keys.email)
            .unique(on: keys.username)
            
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema(schema).delete()
    }
}