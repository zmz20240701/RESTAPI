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
  static func create(_ req: Request, createDTO: CreateDTO) async throws -> Answer
  //
  static func get(_ req: Request, object: String) async throws -> Answer
  static func update(_ req: Request, object: String, updateDTO: UpdateDTO) async throws -> Answer
  static func delete(_ req: Request, object: String) async throws -> Status
}

protocol UpdateUserProtocol {

}
/// A type alias representing the Data Transfer Object (DTO) used for updating entities.
///
/// DTOs are objects that carry data between processes in order to reduce the number of method calls.
/// They are often used in the context of REST APIs to encapsulate data for transfer.
///
/// - Note: The specific type of `UpdateDTO` should be defined by the conforming type.
