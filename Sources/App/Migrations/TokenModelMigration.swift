import Fluent
import Foundation
import Vapor

struct TokenModelMigration: Migration {

  func prepare(on database: Database) -> EventLoopFuture<Void> {
    database.schema(SchemaEnum.tokens.rawValue)
      .id()
      .field(TokenModel.FieldKeys.value, .string, .required)
      .field(TokenModel.FieldKeys.userID, .uuid, .required)
      .create()
  }

  func revert(on database: Database) -> EventLoopFuture<Void> {
    database.schema(SchemaEnum.tokens.rawValue).delete()
  }
}
