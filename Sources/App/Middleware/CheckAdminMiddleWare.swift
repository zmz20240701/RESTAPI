//
//  File.swift
//  RESTAPI
//
//  Created by 赵康 on 2024/9/30.
//

import Foundation
import Vapor

// 自定义中间件, 用于检查用户是否是管理员
struct CheckAdminMiddleWare: AsyncMiddleware {
  func respond(to request: Request, chainingTo next: any AsyncResponder) async throws -> Response {
    // 检查两个条件, 1. 用户是否经过身份验证, 2. 用户是否是管理员
    guard let user = request.auth.get(UserModel.self), user.role == RoleEum.admin.rawValue else {
      throw Abort(.forbidden, reason: "This is for admin")
    }

    // 如果用户是管理员, 则继续处理请求
    return try await next.respond(to: request)
  }
}

// 中间件在处理请求之前和之后进行一些额外的逻辑操作
