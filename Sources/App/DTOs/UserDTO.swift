import Fluent
import Foundation
import Vapor

struct CreateUserDTO: Content {
  let email: String
  let password: String
  let username: String?
  let verifyPassword: String?
}

struct UpdateUserDTO: Content {
  let email: String
  let username: String?
  let lastname: String?
  let name: String?
  let city: String?
  let country: String?
  let address: String?
  let postalcode: String?
}
