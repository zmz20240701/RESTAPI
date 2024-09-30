import Fluent
import Foundation
import Vapor

struct ArticleService: ContentProtocol {
  typealias Answer = ArticleModel
  typealias Request = Vapor.Request
  typealias CreateDTO = CreateArticleDTO
  typealias UpdateDTO = UpdateArticleDTO
  typealias Status = HTTPStatus
  typealias Model = ArticleModel

  static func create(_ req: Request, createDTO: CreateArticleDTO, author: UserModel) async throws
    -> HTTPStatus {
    let slug: String? = createDTO.title?.lowercased().replacingOccurrences(of: " ", with: "-")
    guard
      let guide = try await GuideModel.query(on: req.db)
        .filter(\.$slug == createDTO.slug)
        .first()
    else {
      throw Abort(.notFound, reason: "Guide not found")
    }
    let article = ArticleModel(
      id: UUID(),
      title: createDTO.title,
      slug: slug,
      excerpt: createDTO.excerpt,
      content: "",
      guide: createDTO.guide,
      headerImage: createDTO.headerImage,
      author: "",
      status: createDTO.status ?? StatusEnum.draft.rawValue,
      price: createDTO.price ?? guide.price,
      role: createDTO.role,
      createdAt: Date(),
      updatedAt: Date(),
      publishedAt: createDTO.publishedDate,
      tags: createDTO.tags
    )
    try await article.save(on: req.db)
    return .created
  }

  static func get(_ req: Request, object: String) async throws -> ArticleModel {
    guard
      let article = try await ArticleModel.query(on: req.db)
        .filter(\.$slug == object)
        .first()
    else {
      throw Abort(.notFound, reason: "Article not found")
    }
    return article
  }

  static func getAll(_ req: Request) async throws -> [ArticleModel] {
    let articles = try await ArticleModel.query(on: req.db).all()
    return articles
  }

  static func update(_ req: Request, object: String, updateDTO: UpdateArticleDTO) async throws
    -> HTTPStatus {
    guard
      let article = try await ArticleModel.query(on: req.db)
        .filter(\.$slug == object)
        .first()
    else {
      throw Abort(.notFound, reason: "Article not found")
    }
    article.title = updateDTO.title ?? article.title
    article.excerpt = updateDTO.excerpt ?? article.excerpt
    article.content = updateDTO.content ?? article.content
    article.guide = updateDTO.guide ?? article.guide
    article.headerImage = updateDTO.headerImage ?? article.headerImage
    article.status = updateDTO.status ?? article.status
    article.price = updateDTO.price ?? article.price
    article.role = updateDTO.role ?? article.role
    article.updatedAt = Date()
        article.publishedDate = updateDTO.publishedDate ?? article.publishedDate
    article.tags = updateDTO.tags ?? article.tags

    try await article.save(on: req.db)
    return .ok
  }

  static func delete(_ req: Request, object: String) async throws -> HTTPStatus {
    guard
      let article = try await ArticleModel.query(on: req.db)
        .filter(\.$slug == object)
        .first()
    else {
      throw Abort(.notFound, reason: "Article not found")
    }
    try await article.delete(on: req.db)
    return .noContent
  }
}
