import Fluent
import Foundation
import Vapor

struct CreateSessionDTO: Content {
  let title: String?
  let mp4URL: String?
  let hlsURL: String?
  let publishedAt: Date?
  let status: StatusEnum.RawValue?
  let price: PriceEnum.RawValue?
  let article: UUID?
  let course: UUID?
  let slug: String?
}

struct UpdateSessionDTO: Content {
  let title: String?
  let mp4URL: String?
  let hlsURL: String?
  let publishedAt: Date?
  let status: StatusEnum.RawValue?
  let price: PriceEnum.RawValue?
  let article: UUID?
  let course: UUID?
  let slug: String?
}
