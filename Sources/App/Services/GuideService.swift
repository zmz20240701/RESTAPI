import Fluent
import Foundation
import Vapor

struct GuideService: ContentProtocol {
  typealias Answer = GuideModel
  typealias Request = Vapor.Request
  typealias CreateDTO = CreateGuideDTO
  typealias UpdateDTO = UpdateGuideDTO
  typealias Status = HTTPStatus
  typealias Model = GuideModel

  static func create(_ req: Request, createDTO: CreateDTO, author: UserModel) async throws -> Status
  {
    let guide = GuideModel(
      id: UUID(),
      title: createDTO.title,
      slug: createDTO.title?.lowercased().replacingOccurrences(of: " ", with: "-"),
      tags: createDTO.tags,
      description: createDTO.description,
      status: createDTO.status,
      price: createDTO.price,
      headerImage: createDTO.headerImage,
      author: author.name,
      createdAt: Date(),
      updatedAt: Date(),
      publishedDate: createDTO.publishedDate
    )
    try await guide.save(on: req.db)
    return .created
  }

  static func get(_ req: Request, object: String) async throws -> Model {
    guard
      let guide = try await GuideModel.query(on: req.db)
        .filter(\.$slug == object)
        .first()
    else {
      throw Abort(.notFound, reason: "Guide not found")
    }
    return guide
  }

  static func getAll(_ req: Request) async throws -> [Model] {
    let guides = try await GuideModel.query(on: req.db).all()
    return guides
  }

  static func update(_ req: Request, object: String, updateDTO: UpdateDTO) async throws -> Status {
    guard
      let guide = try await GuideModel.query(on: req.db)
        .filter(\.$slug == object)
        .first()
    else {
      throw Abort(.notFound, reason: "Guide not found")
    }
    guide.title = updateDTO.title ?? guide.title
    guide.tags = updateDTO.tags ?? guide.tags
    guide.description = updateDTO.description ?? guide.description
    guide.status = updateDTO.status ?? guide.status
    guide.price = updateDTO.price ?? guide.price
    guide.headerImage = updateDTO.headerImage ?? guide.headerImage
    guide.publishedDate = updateDTO.publishedDate ?? guide.publishedDate
    guide.updatedAt = Date()
    try await guide.save(on: req.db)
    return .ok
  }

  static func delete(_ req: Request, object: String) async throws -> Status {
    guard
      let guide = try await GuideModel.query(on: req.db)
        .filter(\.$slug == object)
        .first()
    else {
      throw Abort(.notFound, reason: "Guide not found")
    }
    try await guide.delete(on: req.db)
    return .noContent
  }
}
