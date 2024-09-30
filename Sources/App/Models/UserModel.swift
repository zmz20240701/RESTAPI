//
//  File.swift
//  RESTAPI
//
//  Created by 赵康 on 2024/9/28.
//

import Fluent
import Foundation
import Vapor

final class UserModel: Model, @unchecked Sendable {
  static var schema: String {
    SchemaEnum.users.rawValue
  }

  @ID(key: .id)
  var id: UUID?

  @OptionalField(key: FieldKeys.name)  // 可选字段
  var name: String?

  @OptionalField(key: FieldKeys.lastname)
  var lastname: String?

  @OptionalField(key: FieldKeys.username)
  var username: String?

  @Field(key: FieldKeys.password)
  var password: String

  @Field(key: FieldKeys.email)
  var email: String

  @OptionalField(key: FieldKeys.city)
  var city: String?

  @OptionalField(key: FieldKeys.country)
  var country: String?

  @OptionalField(key: FieldKeys.address)
  var address: String?

  @OptionalField(key: FieldKeys.postalcode)
  var postalcode: String?

  @Field(key: FieldKeys.role)
  var role: RoleEum.RawValue

  @OptionalField(key: FieldKeys.subscriptionIsActiveTill)
  var subscriptionIsActiveTill: Date?

  @OptionalField(key: FieldKeys.myCourse)
  var myCourse: [UUID]?

  @OptionalField(key: FieldKeys.completedCourse)
  var completedCourse: [UUID]?

  @OptionalField(key: FieldKeys.bio)
  var bio: String?

  @Timestamp(key: FieldKeys.createdAt, on: .create)
  var createAt: Date?

  @Timestamp(key: FieldKeys.updateAt, on: .update)
  var updateAt: Date?

  @OptionalField(key: FieldKeys.userImage)
  var userImage: URL?

  init() {}

  init(
    username: String?, email: String, password: String, role: RoleEum.RawValue, createAt: Date?,
    updateAt: Date?
  ) {
    self.username = username
    self.email = email
    self.password = password
    self.role = role
    self.createAt = createAt
    self.updateAt = updateAt
  }

  init(
    id: UUID? = nil,
    name: String? = nil,
    lastname: String? = nil,
    username: String? = nil,
    password: String,
    email: String,
    city: String? = nil,
    country: String? = nil,
    address: String? = nil,
    postalcode: String? = nil,
    role: RoleEum.RawValue,
    subscriptionIsActiveTill: Date? = nil,
    myCourse: [UUID]? = nil,
    completedCourse: [UUID]? = nil,
    bio: String? = nil,
    createAt: Date? = nil,
    updateAt: Date? = nil
  ) {
    self.name = name
    self.lastname = lastname
    self.username = username
    self.password = password
    self.email = email
    self.city = city
    self.country = country
    self.address = address
    self.postalcode = postalcode
    self.bio = bio
    self.createAt = createAt
    self.updateAt = updateAt
  }
  // 多个构造函数为 UserModel 提供了极大的灵活性, 以适应不同场景下的对象创建需求
  // 你可以根据不同的场景传递不同的数量的参数, 从而避免不必要的数据

  init(subscriptionIsActiveTill: Date?) {
    self.subscriptionIsActiveTill = subscriptionIsActiveTill
  }

  init(myCourse: [UUID]?) {
    self.myCourse = myCourse
  }

  init(completedCourse: [UUID]?) {
    self.completedCourse = completedCourse
  }

  init(userImage: URL?) {
    self.userImage = userImage
  }

  // 这个类的主要目的是作为一个数据传输对象(DTO), 用于在不同的层之间传递数据
  final class Public: Content {
    // Content 表示这个类可以被编码和解码为 HTTP 请求和相应的内容
    var id: UUID?
    var name: String?
    var lastname: String?
    var username: String?
    var email: String?
    var city: String?
    var country: String?
    var address: String?
    var postalcode: String?
    var role: RoleEum.RawValue?
    var subscriptionIsActiveTill: Date?
    var myCourse: [UUID]?
    var completedCourse: [UUID]?
    var bio: String?
    var updateAt: Date?

    init(
      id: UUID?,
      name: String?,
      lastname: String?,
      username: String?,
      email: String,
      city: String?,
      country: String?,
      address: String?,
      postalcode: String?,
      role: RoleEum.RawValue?,
      subscriptionIsActiveTill: Date?,
      myCourse: [UUID]?,
      completedCourse: [UUID]?,
      bio: String?,
      updateAt: Date?
    ) {
      self.id = id
      self.name = name
      self.lastname = lastname
      self.username = username
      self.email = email
      self.city = city
      self.country = country
      self.address = address
      self.postalcode = postalcode
      self.role = role
      self.subscriptionIsActiveTill = subscriptionIsActiveTill
      self.myCourse = myCourse
      self.completedCourse = completedCourse
      self.bio = bio
      self.updateAt = updateAt
    }
  }
}

extension UserModel: Content {}  // 通过扩展 Content 协议, 我们可以将 UserModel 转化为 HTTP 请求和响应的内容
extension UserModel: Authenticatable {}  // 通过扩展 Authenticatable 协议, 我们可以使用 UserModel 作为身份验证的凭证

extension UserModel: ModelAuthenticatable {  // 定义身份验证的字段
  static let usernameKey = \UserModel.$email
  static let passwordHashKey = \UserModel.$password

  func verify(password: String) throws -> Bool {
    try Bcrypt.verify(password, created: self.password)
  }
}

extension UserModel: ModelSessionAuthenticatable {}
extension UserModel: ModelCredentialsAuthenticatable {}

// 通过转化为公共模型, 我们可以隐藏一些敏感信息, 以保护用户的隐私
extension UserModel {
  func convertToPublic() -> UserModel.Public {
    UserModel.Public(
      id: id,
      name: name,
      lastname: lastname,
      username: username,
      email: email,
      city: city,
      country: country,
      address: address,
      postalcode: postalcode,
      role: role,
      subscriptionIsActiveTill: subscriptionIsActiveTill,
      myCourse: myCourse,
      completedCourse: completedCourse,
      bio: bio,
      updateAt: updateAt
    )
  }
}

// 通过扩展 Collection 协议, 我们可以将 UserModel 数组转化为 UserModel.Public 数组
extension Collection where Element == UserModel {
  func convertToPublic() -> [UserModel.Public] {
    self.map { $0.convertToPublic() }
  }
}
