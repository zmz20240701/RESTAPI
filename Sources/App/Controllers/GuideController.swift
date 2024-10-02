//
//  File.swift
//  RESTAPI
//
//  Created by 赵康 on 2024/10/1.
//

import Foundation
import Vapor

struct GuideController: ContentHandlerProtocol {
    typealias answer = GuideContext

  typealias model = GuideModel

  typealias request = Vapor.Request

  typealias status = HTTPStatus
  @Sendable
  func create(_ req: Vapor.Request) async throws -> Vapor.HTTPStatus {
    let author = (req.auth.get(UserModel.self))!
    let guide = try req.content.decode(CreateGuideDTO.self)
    return try await GuideService.create(req, createDTO: guide, author: author)
  }

  @Sendable
  func get(_ req: Vapor.Request) async throws -> GuideModel {
    let guide = req.parameters.get("slug") // 从HTTP请求中获取 slug
    // 根据传入的 slug 参数, 来查询数据库, 返回 guide
    return try await GuideService.get(req, object: guide!)
  }

  @Sendable
  func getAll(_ req: Vapor.Request) async throws -> [GuideModel] {
    return try await GuideService.getAll(req)
  }

  @Sendable
  func update(_ req: Vapor.Request) async throws -> GuideModel {
    let guide = req.parameters.get("slug")
    let updateGuide = try req.content.decode(UpdateGuideDTO.self)
    return try await GuideService.update(req, object: guide!, updateDTO: updateGuide)
  }

  @Sendable
  func delete(_ req: Vapor.Request) async throws -> Vapor.HTTPStatus {
    let guide = req.parameters.get("slug")
    return try await GuideService.delete(req, object: guide!)
  }
}

extension GuideController: BackendFilterHandlerProtocol {
    @Sendable
    func getByStatus(_ req: Vapor.Request) async throws -> [GuideModel] {
        let status = req.parameters.get("status")
        return try await GuideService.getByStatus(req, status: status!)
    }
    @Sendable
    func search(_ req: Vapor.Request) async throws -> [GuideModel] {
        let query = req.parameters.get("query")
        return try await GuideService.search(req, query: query!)
    }
}

extension GuideController: FrontendHandlerProtocol {
    @Sendable
    func getObject(_ req: Vapor.Request) async throws -> GuideContext {
        let guide = req.parameters.get("slug")
        return try await GuideService.getObject(req, object: guide!)
    }
    @Sendable
    func getAllObject(_ req: Vapor.Request) async throws -> [GuideModel] {
        return try await GuideService.getAllObjects(req)
    }
}
