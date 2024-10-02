//
//  File.swift
//  RESTAPI
//
//  Created by 赵康 on 2024/10/1.
//

import Foundation
import Fluent
import Vapor

protocol FrontendProtocol {
    associatedtype model
    associatedtype answer
    associatedtype status
    associatedtype request
    
    static func getObject(_ req: request, object: String) async throws -> answer
    static func getAllObjects(_ req: request) async throws -> [model]
}

protocol ChangeUserInformationProtocol {
    associatedtype model
    associatedtype status
    associatedtype request
    
    static func addCourseToMyCourse(_ req: request, object: UUID) async throws -> status
    static func addCourseToCompletedCourse(_ req: request, object: UUID) async throws -> status
}

protocol GetSelectedObjectProtocol {
    associatedtype model
    associatedtype request
    
    static func getSelectionObject(_ req: request, object: String) async throws -> model
}

protocol FrontendHandlerProtocol {
    associatedtype model
    associatedtype answer
    associatedtype status
    associatedtype request
    
    func getObject(_ req: request) async throws -> answer
    func getAllObject(_ req: request) async throws -> [model]
}

protocol GetSelectedObjectHandler {
    associatedtype answer
    associatedtype request
    associatedtype model
    
    func getSelectedObject(_ req: request) async throws -> model
}
