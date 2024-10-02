import Fluent
import Foundation
import Vapor

protocol UserProtocol {
  associatedtype Model
  associatedtype Answer
  associatedtype Request
  associatedtype CreateDTO
  associatedtype UpdateDTO
  associatedtype Status

  // MARK: - CRUD Operations
  static func create(_ req: Request, _ createDTO: CreateDTO) async throws -> Answer
  //
  static func get(_ req: Request, object: String) async throws -> Answer
  static func update(_ req: Request, object: String, updateDTO: UpdateDTO) async throws -> Answer
  static func delete(_ req: Request, object: String) async throws -> Status
}

protocol UserHandlerProtocol {
  associatedtype answer
  associatedtype request
  associatedtype status

  func create(_ req: request) async throws -> answer
  func get(_ req: request ) async throws -> answer
  func update(_ req: request ) async throws -> answer
  func delete(_ req: request) async throws -> status

}

