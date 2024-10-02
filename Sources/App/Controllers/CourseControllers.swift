//
//  File.swift
//  RESTAPI
//
//  Created by 赵康 on 2024/10/1.
//

import Foundation
import Vapor
import Fluent

struct CourseControllers: ContentHandlerProtocol {

    typealias answer = CourseContext
    
    typealias model = CourseModel
    
    typealias request = Vapor.Request
    
    typealias status = HTTPStatus
    @Sendable
    func create(_ req: Request) async throws -> HTTPStatus {
        let course = try req.content.decode(CreateCourseDTO.self)
        let author = req.auth.get(UserModel.self)
        return try await CourseService.create(req, createDTO: course, author: author!)
    }
    @Sendable
    func get(_ req: Vapor.Request) async throws -> CourseModel {
        let course = req.parameters.get("slug")
        return try await CourseService.get(req, object: course!)
    }
    @Sendable
    func getAll(_ req: Vapor.Request) async throws -> [CourseModel] {
        return try await CourseService.getAll(req)
    }
    @Sendable
    func update(_ req: Vapor.Request) async throws -> CourseModel {
        let course = req.parameters.get("slug")
        let updatedCourse = try req.content.decode(UpdateCourseDTO.self)
        return try await CourseService.update(req, object: course!, updateDTO: updatedCourse)
    }
    @Sendable
    func delete(_ req: Vapor.Request) async throws -> Vapor.HTTPStatus {
        let course = req.parameters.get("slug")
        return try await CourseService.delete(req, object: course!)
    }
}

extension CourseControllers: BackendFilterHandlerProtocol {
    @Sendable
    func getByStatus(_ req: Request) async throws -> [CourseModel] {
        let status = req.parameters.get("status")
        return try await CourseService.getByStatus(req, status: status!)
    }
    @Sendable
    func search(_ req: Request) async throws -> [CourseModel] {
        let query = req.parameters.get("query")
        return try await CourseService.search(req, query: query!)
    }
}

extension CourseControllers: FrontendHandlerProtocol {
    @Sendable
    func getObject(_ req: Vapor.Request) async throws -> CourseContext {
        let course = req.parameters.get("slug")
        return try await CourseService.getObject(req, object: course!)
    }
    @Sendable
    func getAllObject(_ req: Vapor.Request) async throws -> [CourseModel] {
        return try await CourseService.getAllObjects(req)
    }
}
