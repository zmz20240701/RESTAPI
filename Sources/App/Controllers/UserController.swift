import Fluent
import Foundation
import Vapor

struct UserController: UserHandlerProtocol {
  @Sendable
  func create(_ req: Vapor.Request) async throws -> UserModel.Public {
    let user = try req.content.decode(CreateUserDTO.self)
    return try await UserService.create(req, user)
  }

  @Sendable
  func get(_ req: Vapor.Request) async throws -> UserModel.Public {
    let user = try req.auth.require(UserModel.self)
    return try await UserService.get(req, object: user.id!.uuidString)
  }

  @Sendable
  func update(_ req: Vapor.Request) async throws -> UserModel.Public {
    let user = try req.auth.require(UserModel.self)
    let updateUser = try req.content.decode(UpdateUserDTO.self)
    return try await UserService.update(req, object: user.id!.uuidString, updateDTO: updateUser)
  }

  @Sendable
  func delete(_ req: Vapor.Request) async throws -> Vapor.HTTPStatus {
    let user = try req.auth.require(UserModel.self)
    return try await UserService.delete(req, object: user.id!.uuidString)
  }

  typealias answer = UserModel.Public
  typealias request = Request
  typealias status = HTTPStatus
}

extension UserController: SearchUserProtocol {
    @Sendable
    static func search(_ req: Vapor.Request, query: String) async throws -> [UserModel.Public] {
        let query = req.parameters.get("query")
        return try await UserService.search(req, query: query!)
    }
}
