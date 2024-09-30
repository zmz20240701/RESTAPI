import Fluent
import Foundation
import Vapor

final class TokenModel: Model, @unchecked Sendable {
  static let schema = SchemaEnum.tokens.rawValue
  @ID(key: .id)
  var id: UUID?

  @Field(key: FieldKeys.value)
  var value: String

  @Parent(key: FieldKeys.userID)
  var userID: UserModel

  init() {}

    init(id: UUID? = nil, value: String, userID: UserModel.IDValue) {
    self.id = id
    self.value = value
        self.$userID.id = userID
  }

}

extension TokenModel {
  typealias UserAlias = App.UserModel
    static let valueKey = \TokenModel.$value
    static let userKey = \TokenModel.$userID
  var isValid: Bool {
    true
  }
}

extension TokenModel {
  static func generate(for user: UserModel) throws -> TokenModel {
    let randomValue = [UInt8].random(count: 16).base64
    return try TokenModel(value: randomValue, userID: user.requireID())
  }
}
extension TokenModel: Content {}
