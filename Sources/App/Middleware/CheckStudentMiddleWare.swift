//
//  File.swift
//  RESTAPI
//
//  Created by 赵康 on 2024/10/2.
//

import Foundation
import Fluent
import Vapor

struct CheckStudentMiddleWare: AsyncMiddleware {
    func respond(to request: Vapor.Request, chainingTo next: any Vapor.AsyncResponder) async throws -> Vapor.Response {
        guard
            let user = request.auth.get(UserModel.self),
            user.role == RoleEum.student.rawValue
        else {
            throw Abort(.forbidden, reason: "This is for Student")
        }
        return try await next.respond(to: request)
    }
}
