import Fluent
import Foundation
import Vapor

struct CreateGuideDTO: Content {
  let title: String?
  let description: String?
  let headerImage: String?
  let price: PriceEnum.RawValue?
  let status: StatusEnum.RawValue?
  let tags: [String]?
  let publishedDate: Date?
}

struct UpdateGuideDTO: Content {
  let title: String?
  let description: String?
  let headerImage: String?
  let price: PriceEnum.RawValue?
  let status: StatusEnum.RawValue?
  let tags: [String]?
  let publishedDate: Date?
}
