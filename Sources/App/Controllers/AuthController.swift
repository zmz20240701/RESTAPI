//
//  File.swift
//  RESTAPI
//
//  Created by 赵康 on 2024/9/30.
//

import Fluent
import Foundation
import Vapor

struct AuthController: AuthProtocol {
    
    @Sendable
    func loginHandler(_ req: Request) throws -> EventLoopFuture<TokenModel> {
        // 从请求的身份验证中获取用户, 侧面说明了, 用户已经经过身份验证
        let user = try req.auth.require(UserModel.self)
        // 为已经认证的用户生成一个令牌, 并保存到数据库中
        let token = try TokenModel.generate(for: user)
        return token.save(on: req.db).map { token }  // 保存成功后返回令牌
    }
}
