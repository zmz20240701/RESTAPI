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
  var userID: UserModel  // 外键
  // 通过self.userID你可以访问关联的完整的UserModel对象
  init() {}

  init(id: UUID? = nil, value: String, userID: UserModel.IDValue) {
    // 这里的userID跟上边属性声明中的 var userID不同
    self.value = value
    self.$userID.id = userID  // 这里的userID就是属性声明中的userID
  }  // 通过子表中的外键, 关联到了父表的主键

  // 允许你在创建TokenModel实例时仅仅传递父模型的 ID, 因为在创建子模型时, 通常不需要
  // 传递整个父模型, 只需要知道父模型的逐渐 ID 就能建立关系

}

extension TokenModel: ModelTokenAuthenticatable {
  typealias UserAlias = App.UserModel
  static let valueKey = \TokenModel.$value  // 认证系统令牌的值存储在哪一个字段中
  static let userKey = \TokenModel.$userID  // 令牌对应的用户信息存储在哪一个字段中
  var isValid: Bool { true }
}
// 这段代码允许你根据令牌(TokenModel 的 Value 字段)来验证用户,并根据UserID 字段来获取
// 关联到的用户信息

extension TokenModel {
  static func generate(for user: UserModel) throws -> TokenModel {
    let randomValue = [UInt8].random(count: 16).base64
    return try TokenModel(value: randomValue, userID: user.requireID())
  }
}
extension TokenModel: Content {}

// 实现了ModelTokenAuthenticatable协议的模型可以被用作令牌来认证用户
