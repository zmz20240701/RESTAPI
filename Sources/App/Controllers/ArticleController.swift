//
//  File.swift
//  RESTAPI
//
//  Created by 赵康 on 2024/10/1.
//

import Fluent
import Foundation
import Vapor

struct ArticleController: ContentHandlerProtocol {
  typealias answer = ArticleModel

  typealias model = ArticleModel

  typealias request = Vapor.Request

  typealias status = HTTPStatus
  @Sendable
  func create(_ req: Vapor.Request) async throws -> Vapor.HTTPStatus {
    let author = req.auth.get(UserModel.self)
    let article = try req.content.decode(CreateArticleDTO.self)
    return try await ArticleService.create(req, createDTO: article, author: author!)
  }

  @Sendable
  func get(_ req: Vapor.Request) async throws -> ArticleModel {
    let article = req.parameters.get("slug")
    return try await ArticleService.get(req, object: article!)
  }

  @Sendable
  func getAll(_ req: Vapor.Request) async throws -> [ArticleModel] {
    return try await ArticleService.getAll(req)
  }

  @Sendable
  func update(_ req: Vapor.Request) async throws -> ArticleModel {
    let article = req.parameters.get("slug")
    let updatedArticle = try req.content.decode(UpdateArticleDTO.self)
    return try await ArticleService.update(req, object: article!, updateDTO: updatedArticle)
  }

  @Sendable
  func delete(_ req: Vapor.Request) async throws -> Vapor.HTTPStatus {
    let article = req.parameters.get("slug")
    return try await ArticleService.delete(req, object: article!)
  }
}

extension ArticleController: BackendFilterHandlerProtocol {
   @Sendable
  func getByStatus(_ req: Vapor.Request) async throws -> [ArticleModel] {
    let status = req.parameters.get("status")
    return try await ArticleService.getByStatus(req, status: status!)
  }
    @Sendable
  func search(_ req: Vapor.Request) async throws -> [ArticleModel] {
    let query = req.parameters.get("query")
    return try await ArticleService.search(req, query: query!)
  }
}

extension ArticleController: GetSelectedObjectHandler {
    @Sendable
    func getSelectedObject(_ req: Vapor.Request) async throws -> ArticleModel {
        let article = req.parameters.get("articleSlug")
        return try await ArticleService.getSelectionObject(req, object: article!)
    }
}
