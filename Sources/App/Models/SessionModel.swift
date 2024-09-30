//
//  File.swift
//  RESTAPI
//
//  Created by 赵康 on 2024/9/28.
//

import Fluent
import Foundation
import Vapor

final class SessionModel: Model, @unchecked Sendable {
  static let schema: String = SchemaEnum.sessions.rawValue

  @ID(key: .id)
  var id: UUID?

  @OptionalField(key: FieldKeys.title)
  var title: String?

  @OptionalField(key: FieldKeys.mp4URL)
  var mp4URL: String?

  @OptionalField(key: FieldKeys.hlsURL)
  var hlsURL: String?

  @Timestamp(key: FieldKeys.createdAt, on: .create)
  var createdAt: Date?

  @Timestamp(key: FieldKeys.updatedAt, on: .update)
  var updatedAt: Date?

  @OptionalField(key: FieldKeys.publishedAt)
  var publishedAt: Date?

  @OptionalField(key: FieldKeys.status)
  var status: StatusEnum.RawValue?

  @OptionalField(key: FieldKeys.price)
  var price: PriceEnum.RawValue?

  @OptionalField(key: FieldKeys.article)
  var article: UUID?

  @OptionalField(key: FieldKeys.course)
  var course: UUID?

  @OptionalField(key: FieldKeys.slug)
  var slug: String?

  init() {}

  init(
    id: UUID? = nil,
    title: String? = nil,
    mp4URL: String? = nil,
    hlsURL: String? = nil,
    createdAt: Date? = nil,
    updatedAt: Date? = nil,
    publishedAt: Date? = nil,
    status: StatusEnum.RawValue? = nil,
    price: PriceEnum.RawValue? = nil,
    article: UUID? = nil,
    course: UUID? = nil,
    slug: String? = nil
  ) {
    self.id = id
    self.title = title
    self.mp4URL = mp4URL
    self.hlsURL = hlsURL
    self.createdAt = createdAt
    self.updatedAt = updatedAt
    self.publishedAt = publishedAt
    self.status = status
    self.price = price
    self.article = article
    self.course = course
    self.slug = slug
  }
}
extension SessionModel: Content {}
