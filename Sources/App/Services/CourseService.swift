import Fluent
import Foundation
import Vapor

struct CourseService: ContentProtocol {
  typealias Answer = CourseModel
  typealias Request = Vapor.Request
  typealias CreateDTO = CreateCourseDTO
  typealias UpdateDTO = UpdateCourseDTO
  typealias Status = HTTPStatus
  typealias Model = CourseModel

  static func create(_ req: Request, createDTO: CreateCourseDTO, author: UserModel) async throws -> HTTPStatus {
      let _: String? = createDTO.title?.lowercased().replacingOccurrences(of: " ", with: "-")

    let course = CourseModel()
    course.title = createDTO.title
    course.tags = createDTO.tags
    course.description = createDTO.description
    course.status = createDTO.status
    course.price = createDTO.price
    course.headerImage = createDTO.headerImage
    course.article = createDTO.article
    course.topHexColor = createDTO.topHexColor
    course.bottomHexColor = createDTO.bottomHexColor
    course.sylabus = createDTO.sylabus
    course.assets = createDTO.assets
    course.publishedDate = createDTO.publishedDate
    course.author = author.name

    try await course.save(on: req.db)
    return .created
  }

  static func get(_ req: Request, object: String) async throws -> CourseModel {
    guard
      let course = try await CourseModel.query(on: req.db)
        .filter(\.$slug == object)
        .first()
    else {
      throw Abort(.notFound, reason: "Course not found")
    }
    return course
  }

  static func getAll(_ req: Request) async throws -> [CourseModel] {
    let courses = try await CourseModel.query(on: req.db).all()
    return courses
  }

  static func update(_ req: Request, object: String, updateDTO: UpdateCourseDTO) async throws -> HTTPStatus {
    guard
      let course = try await CourseModel.query(on: req.db)
        .filter(\.$slug == object)
        .first()
    else {
      throw Abort(.notFound, reason: "Course not found")
    }
    course.title = updateDTO.title ?? course.title
    course.tags = updateDTO.tags ?? course.tags
    course.description = updateDTO.description ?? course.description
    course.status = updateDTO.status ?? course.status
    course.price = updateDTO.price ?? course.price
    course.headerImage = updateDTO.headerImage
    course.article = updateDTO.article ?? course.article
    course.topHexColor = updateDTO.topHexColor ?? course.topHexColor
    course.bottomHexColor = updateDTO.bottomHexColor ?? course.bottomHexColor
    course.sylabus = updateDTO.sylabus ?? course.sylabus
    course.assets = updateDTO.assets ?? course.assets
    course.publishedDate = updateDTO.publishedDate ?? course.publishedDate
    course.updatedAt = Date()
    try await course.save(on: req.db)
    return .ok
  }

  static func delete(_ req: Request, object: String) async throws -> HTTPStatus {
    guard
      let course = try await CourseModel.query(on: req.db)
        .filter(\.$slug == object)
        .first()
    else {
      throw Abort(.notFound, reason: "Course not found")
    }
    try await course.delete(on: req.db)
    return .noContent
  }
}
