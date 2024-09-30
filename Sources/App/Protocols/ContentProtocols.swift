import Fluent
import Foundation
import Vapor

protocol ContentProtocol {
  associatedtype Answer
  associatedtype Request
  associatedtype CreateDTO
  associatedtype UpdateDTO
  associatedtype Status
  associatedtype Model

  // MARK: - CRUD Operations
  static func create(_ req: Request, createDTO: CreateDTO, author: UserModel) async throws -> Status
  static func get(_ req: Request, object: String) async throws -> Model
  static func getAll(_ req: Request) async throws -> [Model]
  static func update(_ req: Request, object: String, updateDTO: UpdateDTO) async throws -> Status
  static func delete(_ req: Request, object: String) async throws -> Status

}
