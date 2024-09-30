import Fluent
import Foundation
import Vapor

protocol ContentFilterProtocol {
  associatedtype Answer
  associatedtype Request
  associatedtype Status
  associatedtype Model

  func search(_ req: Request, query: String) async throws -> [Model]

}

protocol BackendContentFilterProtocol {
  associatedtype Answer
  associatedtype Request
  associatedtype Status
  associatedtype Model

  func getByStatus(_ req: Request, status: StatusEnum.RawValue) async throws -> [Model]
  func getAllWithAuthor(_ req: Request, author: UserModel) async throws -> [Model]
  func search(_ req: Request, query: String) async throws -> [Model]
}
