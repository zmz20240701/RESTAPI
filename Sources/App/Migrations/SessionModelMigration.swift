import Fluent
import Foundation
import Vapor

struct SessionModelMigration: AsyncMigration {
  // Prepares the database for storing SessionModel models.
  let schema: String = SessionModel.schema.self  // 这表示我们将在数据库中创建一个名为“sessions”的表。

  let keys: SessionModel.FieldKeys.Type = SessionModel.FieldKeys.self  // 这是我们将在表中存储的字段的键。

  func prepare(on database: Database) async throws {
    try await database.schema(schema)
      .id()
      .field(keys.title, .string)
      .field(keys.mp4URL, .string)
      .field(keys.hlsURL, .string)
      .field(keys.createdAt, .datetime)
      .field(keys.updatedAt, .datetime)
      .field(keys.publishedAt, .datetime)  // 这将存储会话的发布日期。
      .field(keys.status, .string)
      .field(keys.price, .string)
      .field(keys.article, .uuid)  // 这将存储与会话相关的文章的ID。
      .field(keys.course, .uuid)
      .field(keys.slug, .string)
      .unique(on: keys.mp4URL)  // 这将确保我们不会在数据库中存储两个具有相同mp4URL的会话。
      .unique(on: keys.hlsURL)
      .create()
  }

  func revert(on database: Database) async throws {
    try await database.schema(schema).delete()
  }
}
