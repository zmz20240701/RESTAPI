//
//  File.swift
//  RESTAPI
//
//  Created by 赵康 on 2024/10/1.
//

import Foundation
import Vapor
import Fluent

struct SessionController: ContentHandlerProtocol {

    typealias answer = SessionModel
    
    typealias model = SessionModel
    
    typealias request = Vapor.Request
    
    typealias status = HTTPStatus
    @Sendable
     func create(_ req: Vapor.Request) async throws -> Vapor.HTTPStatus {
         let user = req.auth.get(UserModel.self)
         let session = try req.content.decode(CreateSessionDTO.self)
         return try await SessionService.create(req, createDTO: session, author: user!)
    }
   @Sendable
    func get(_ req: Vapor.Request) async throws -> SessionModel {
        let session = req.parameters.get("slug")
        return try await SessionService.get(req, object: session!)
    }
    @Sendable
    func getAll(_ req: Vapor.Request) async throws -> [SessionModel] {
        return try await SessionService.getAll(req)
    }
    @Sendable
    func update(_ req: Vapor.Request) async throws -> SessionModel {
        let session = req.parameters.get("slug")
        let updateSession = try req.content.decode(UpdateSessionDTO.self)
        return try await SessionService.update(req, object: session!, updateDTO: updateSession)
    }
    @Sendable
    func delete(_ req: Vapor.Request) async throws -> Vapor.HTTPStatus {
        let session = req.parameters.get("slug")
        return try await SessionService.delete(req, object: session!)
    }
}

extension SessionController: BackendFilterHandlerProtocol {
    @Sendable
    func getByStatus(_ req: Vapor.Request) async throws -> [SessionModel] {
        let status = req.parameters.get("status")
        return try await SessionService.getByStatus(req, status: status!)
    }
    @Sendable
    func search(_ req: Vapor.Request) async throws -> [SessionModel] {
        let query = req.parameters.get("query")
        return try await SessionService.search(req, query: query!)
    }
}

extension SessionController: GetSelectedObjectHandler {
    @Sendable
    func getSelectedObject(_ req: Vapor.Request) async throws -> SessionModel {
        let session = req.parameters.get("articleSlug")
        return try await SessionService.getSelectionObject(req, object: session!)
    }
}
