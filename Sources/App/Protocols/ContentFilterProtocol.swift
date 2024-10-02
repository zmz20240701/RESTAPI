import Fluent
import Foundation
import Vapor

protocol ContentFilterProtocol {
  associatedtype Answer
  associatedtype Request
  associatedtype Status
  associatedtype Model

  static func search(_ req: Request, query: String) async throws -> [Model]

}

protocol BackendContentFilterProtocol {
  associatedtype Answer
  associatedtype Request
  associatedtype Status
  associatedtype Model

  static func getByStatus(_ req: Request, status: StatusEnum.RawValue) async throws -> [Model]
  static func search(_ req: Request, query: String) async throws -> [Model]
}

protocol SearchUserProtocol {
    associatedtype request
    static func search(_ req: request, query: String) async throws -> [UserModel.Public]
}


protocol BackendFilterHandlerProtocol {
    associatedtype request
    associatedtype model
    associatedtype answer
    
    func getByStatus(_ req: request) async throws -> [model]
    func search(_ req: request) async throws -> [model]
}
