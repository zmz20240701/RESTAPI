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
    static func update(_ req: Request, object: String, updateDTO: UpdateDTO) async throws -> Model
  static func delete(_ req: Request, object: String) async throws -> Status

}

protocol ContentHandlerProtocol {
    associatedtype answer
    associatedtype model
    associatedtype request
    associatedtype status
    
    func create(_ req: request) async throws -> status
    func get(_ req: request) async throws -> model
    func getAll(_ req: request) async throws -> [model]
    func update(_ req: request) async throws -> model
    func delete(_ req: request) async throws -> status
}
