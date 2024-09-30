//
//  File.swift
//  RESTAPI
//
//  Created by 赵康 on 2024/9/30.
//

import Foundation
import Fluent
import Vapor

struct AuthController: AuthProtocol {
    func loginHandler(_ req: Request) throws -> EventLoopFuture<TokenModel> {
        let user = try req.auth.require(UserModel.self)
        let token = try TokenModel.generate(for: user)
        return token.save(on: req.db).map { token }
    }
}
