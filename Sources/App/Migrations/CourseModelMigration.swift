import Foundation
import Fluent
import Vapor

struct CourseModelMigration: AsyncMigration {
    let schema: String = CourseModel.schema
    let keys: CourseModel.FieldKeys.Type = CourseModel.FieldKeys.self

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
        .field(keys.article, .string)
        .field(keys.topHexColor, .string)
        .field(keys.bottomHexColor, .string)
        .field(keys.sylabus, .string)
        .field(keys.assets, .string)
        .field(keys.author, .string)
        .field(keys.createdAt, .datetime)
        .field(keys.updatedAt, .datetime)
        .field(keys.publishedDate, .datetime)
        .unique(on: keys.sylabus)
        .unique(on: keys.assets)
        .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema(schema).delete()
    }
}

        /// Adds a new field to the database schema for the `CourseModel` migration.
        /// 
        /// - `slug`: A string field that typically represents a URL-friendly version of a title or name.
        ///            It is often used for creating readable and SEO-friendly URLs.
