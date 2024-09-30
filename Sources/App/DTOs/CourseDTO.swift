import Fluent
import Foundation
import Vapor

struct CreateCourseDTO: Content {
  let title: String?
  let tags: [String]?
  let description: String?
  let status: StatusEnum.RawValue?
  let price: PriceEnum.RawValue?
    let headerImage: String?
  let article: String?
  let topHexColor: String?
  let bottomHexColor: String?
  let sylabus: URL?
  let assets: URL?
  let publishedDate: Date?
}

struct UpdateCourseDTO: Content {
  let title: String?
  let tags: [String]?
  let description: String?
  let status: StatusEnum.RawValue?
  let price: PriceEnum.RawValue?
    let headerImage: String?
  let article: String?
  let topHexColor: String?
  let bottomHexColor: String?
  let sylabus: URL?
  let assets: URL?
  let publishedDate: Date?
}
