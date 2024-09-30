import Fluent
import Foundation
import Vapor

struct CreateArticleDTO: Content {
  let title: String?
  let excerpt: String?
  let content: String?
  let status: StatusEnum.RawValue?
  let price: PriceEnum.RawValue?
  let headerImage: String?
  let role: RoleEum.RawValue?
  let publishedDate: Date?
  let slug: String?
  let tags: [String]?
  let guide: GuideModel.IDValue?
}

struct UpdateArticleDTO: Content {
  let title: String?
  let excerpt: String?
  let content: String?
  let status: StatusEnum.RawValue?
  let price: PriceEnum.RawValue?
  let headerImage: String?
  let role: RoleEum.RawValue?
  let publishedDate: Date?
  let slug: String?
  let tags: [String]?
  let guide: GuideModel.IDValue?
}
