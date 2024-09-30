import Fluent
import Foundation
import Vapor

struct UserService: UserProtocol {
  typealias Model = UserModel
  typealias Answer = UserModel.Public
typealias Request = Vapor.Request
  typealias CreateDTO = CreateUserDTO
  typealias UpdateDTO = UpdateUserDTO
  typealias Status = HTTPStatus

  static func create(_ req: Request, createDTO: CreateUserDTO) async throws -> UserModel.Public {
    let user = UserModel()
    user.email = createDTO.email
    user.password = try Bcrypt.hash(createDTO.password)
    user.username = createDTO.username
      user.role = RoleEum.registered.rawValue
    user.createAt = Date()
    user.updateAt = Date()
    // 符合 CreateDTO 的字段由客户端传入，而不是在服务器端生成, 不符合 CreateDTO 的字段由服务器端生成
    try await user.save(on: req.db)
    return user.convertToPublic()
  }

  static func get(_ req: Request, object: String) async throws -> UserModel.Public {
    guard let uuid = UUID(uuidString: object) else {
      throw Abort(.badRequest, reason: "Invalid UUID")
    }
      guard let user = try await UserModel.find(uuid, on: req.db) else {
      throw Abort(.notFound, reason: "User not found")
    }
    return user.convertToPublic()
  }

  static func update(_ req: Request, object: String, updateDTO: UpdateUserDTO) async throws
    -> UserModel.Public
  {
    guard let uuid = UUID(uuidString: object) else {
      throw Abort(.badRequest, reason: "Invalid UUID")
    }
      guard let user = try await UserModel.find(uuid, on: req.db) else {
      throw Abort(.notFound, reason: "User not found")
    }
      user.email = updateDTO.email
    user.username = updateDTO.username ?? user.username
    user.lastname = updateDTO.lastname ?? user.lastname
    user.name = updateDTO.name ?? user.name
    user.city = updateDTO.city ?? user.city
    user.country = updateDTO.country ?? user.country
    user.address = updateDTO.address ?? user.address
    user.postalcode = updateDTO.postalcode ?? user.postalcode
    user.updateAt = Date()
    try await user.save(on: req.db)
    return user.convertToPublic()
  }

  static func delete(_ req: Request, object: String) async throws -> HTTPStatus {
    guard let uuid = UUID(uuidString: object) else {
      throw Abort(.badRequest, reason: "Invalid UUID")
    }
      guard let user = try await UserModel.find(uuid, on: req.db) else {
      throw Abort(.notFound, reason: "User not found")
    }
    try await user.delete(on: req.db)
    return .ok
  }
}
