import Fluent
import Foundation
import Vapor

// 这里面向的是表格的字段, Model 面向的是应用程序
struct AticleModelMigration: AsyncMigration {
  // Prepares the database for storing ArticleModel models.
  let schema: String = ArticleModel.schema.self  // 这表示我们将在数据库中创建一个名为“articles”的表。

  let keys: ArticleModel.FieldKeys.Type = ArticleModel.FieldKeys.self  // 这是我们将在表中存储的字段的键。

  func prepare(on database: Database) async throws {
    try await database.schema(schema)
      .id()
      .field(keys.title, .string)
      .field(keys.slug, .string)
      .field(keys.excerpt, .string)
      .field(keys.content, .string)
      .field(keys.guide, .uuid)  // 这将存储文章的指南的ID。
      .field(keys.headerImage, .string)
      .field(keys.author, .string)
      .field(keys.status, .string)
      .field(keys.price, .string)
      .field(keys.role, .string)
      .field(keys.createdAt, .datetime)
      .field(keys.updatedAt, .datetime)
      .field(keys.publishedDate, .datetime)  // 这将存储文章的发布日期。
      .field(keys.tags, .array(of: .string))  // 这将存储文章的标签。
      .create()
  }

  func revert(on database: Database) async throws {
    try await database.schema(schema).delete()
  }
}
