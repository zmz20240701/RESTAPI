import Foundation
import Vapor
import Fluent

protocol AuthProtocol {
    func loginHandler(_ req: Request) throws -> EventLoopFuture<TokenModel> 
}
