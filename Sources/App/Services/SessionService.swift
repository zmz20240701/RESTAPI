import Fluent
import Foundation
import Vapor

struct SessionService: ContentProtocol {
  typealias Answer = SessionModel
  typealias Request = Vapor.Request
  typealias CreateDTO = CreateSessionDTO
  typealias UpdateDTO = UpdateSessionDTO
  typealias Status = HTTPStatus
  typealias Model = SessionModel

  static func create(_ req: Request, createDTO: CreateDTO, author: UserModel) async throws -> Status {
    guard
      let course = try await CourseModel.query(on: req.db)
        .filter(\.$slug == createDTO.slug)
        .first()
    else {
      throw Abort(.notFound, reason: "Course not found")
    }
    let session = SessionModel()
    session.title = createDTO.title
    session.mp4URL = createDTO.mp4URL
    session.hlsURL = createDTO.hlsURL
    session.createdAt = Date()
    session.updatedAt = Date()
    session.publishedAt = createDTO.publishedAt
    session.status = createDTO.status
    session.price = createDTO.price ?? course.price
    session.article = createDTO.article
    session.course = course.id
    session.slug = createDTO.title?.lowercased().replacingOccurrences(of: " ", with: "-")

    try await session.save(on: req.db)
    return .created
  }

  static func get(_ req: Request, object: String) async throws -> Model {
    guard
      let session = try await SessionModel.query(on: req.db)
        .filter(\.$slug == object)
        .first()
    else {
      throw Abort(.notFound, reason: "Session not found")
    }
    return session
  }

  static func getAll(_ req: Request) async throws -> [Model] {
    let sessions = try await SessionModel.query(on: req.db).all()
    return sessions
  }

  static func update(_ req: Request, object: String, updateDTO: UpdateDTO) async throws -> Status {
    guard
      let session = try await SessionModel.query(on: req.db)
        .filter(\.$slug == object)
        .first()
    else {
      throw Abort(.notFound, reason: "Session not found")
    }
    session.title = updateDTO.title ?? session.title
    session.mp4URL = updateDTO.mp4URL ?? session.mp4URL
    session.hlsURL = updateDTO.hlsURL ?? session.hlsURL
    session.updatedAt = Date()
    session.publishedAt = updateDTO.publishedAt ?? session.publishedAt
    session.status = updateDTO.status ?? session.status
    session.price = updateDTO.price ?? session.price
    session.article = updateDTO.article ?? session.article
    try await session.save(on: req.db)
    return .ok
  }

  static func delete(_ req: Request, object: String) async throws -> Status {
    guard
      let session = try await SessionModel.query(on: req.db)
        .filter(\.$slug == object)
        .first()
    else {
      throw Abort(.notFound, reason: "Session not found")
    }
    try await session.delete(on: req.db)
    return .noContent
  }
}
