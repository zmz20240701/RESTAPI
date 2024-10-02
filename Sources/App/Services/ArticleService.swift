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
      headerImage: URL(string: createDTO.headerImage!),
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
    -> ArticleModel {
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
        article.headerImage = URL(string: updateDTO.headerImage!) ?? article.headerImage
    article.status = updateDTO.status ?? article.status
    article.price = updateDTO.price ?? article.price
    article.role = updateDTO.role ?? article.role
    article.updatedAt = Date()
        article.publishedDate = updateDTO.publishedDate ?? article.publishedDate
    article.tags = updateDTO.tags ?? article.tags

    try await article.save(on: req.db)
        return article
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

extension ArticleService: BackendContentFilterProtocol {
    static func getByStatus(_ req: Request, status: StatusEnum.RawValue) async throws -> [ArticleModel] {
        let articles = try await ArticleModel.query(on: req.db)
            .filter(\.$status == status)
            .all()
        return articles
    }
    
    // 根据用户提供的查询字符串, 在文章的标题和内容中搜索符合条件的记录
    static func search(_ req: Request, query: String) async throws -> [ArticleModel] {
        let query = try await ArticleModel.query(on: req.db)
        // 代表我们将对ArticleModel表执行查询操作, 并且查询将基于提供的req.db数据库进行链接执行
            .group(.or) { or in // 使用 OR 逻辑组合查询条件
                or.filter(\.$title =~ query) // 在or条件下如何构造具体的查询条件
            }.all()
        return query
    }
}

extension ArticleService: GetSelectedObjectProtocol {
    typealias model = ArticleModel
    
    typealias request = Vapor.Request
    
    static func getSelectionObject(_ req: Request, object: String) async throws -> ArticleModel {
        let user = req.auth.get(UserModel.self)
        guard
            let article = try await ArticleModel.query(on: req.db)
                .filter(\.$slug == object)
                .filter(\.$status == StatusEnum.published.rawValue)
                .first()
        else {
            throw Abort(.notFound)
        }
        return article
    }
}
