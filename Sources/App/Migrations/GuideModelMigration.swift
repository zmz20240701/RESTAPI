import Foundation
import Fluent
import Vapor

struct GuideModelMigration: AsyncMigration {
    let schema: String = GuideModel.schema
    let keys: GuideModel.FieldKeys.Type = GuideModel.FieldKeys.self

    func prepare(on database: Database) async throws {
        try await database.schema(schema)
            .id()
            .field(keys.title, .string)
            .field(keys.slug, .string)
            .field(keys.tags, .array(of: .string))
            .field(keys.description, .string)
            .field(keys.status, .string)
            .field(keys.price, .string)
            .field(keys.headerImage, .string)
            .field(keys.author, .string)
            .field(keys.createdAt, .datetime)
            .field(keys.updatedAt, .datetime)
            .field(keys.publishedDate, .datetime)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema(schema).delete()
    }
}
