import Fluent
import Foundation
import Vapor

extension TokenModel {
  struct FieldKeys {
    static var id: FieldKey { "id" }
    static var value: FieldKey { "value" }
    static var userID: FieldKey { "userID" }
  }
}
