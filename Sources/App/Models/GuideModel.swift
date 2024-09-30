//
//  File.swift
//  RESTAPI
//
//  Created by 赵康 on 2024/9/28.
//

import Foundation
import Fluent
import Vapor

final class GuideModel: Model, @unchecked Sendable {
    static let schema: String = SchemaEnum.guides.rawValue
    
    @ID(key: .id)
    var id: UUID?
    
    @OptionalField(key: FieldKeys.title)
    var title: String?
    
    @OptionalField(key: FieldKeys.slug)
    var slug: String?
    
    @OptionalField(key: FieldKeys.tags)
    var tags: [String]?
    
    @OptionalField(key: FieldKeys.description)
    var description: String?
    
    @OptionalField(key: FieldKeys.status)
    var status: StatusEnum.RawValue?
    
    @OptionalField(key: FieldKeys.price)
    var price: PriceEnum.RawValue?
    
    @OptionalField(key: FieldKeys.headerImage)
    var headerImage: String?
    
    @OptionalField(key: FieldKeys.author)
    var author: String?
    
    @Timestamp(key: FieldKeys.createdAt, on: .create)
    var createdAt: Date?
    
    @Timestamp(key: FieldKeys.updatedAt, on: .update)
    var updatedAt: Date?
    
    @OptionalField(key: FieldKeys.publishedDate)
    var publishedDate: Date?
    
    init() {}
    
    init(
        id: UUID? = nil,
        title: String? = nil,
        slug: String? = nil,
        tags: [String]? = nil,
        description: String? = nil,
        status: StatusEnum.RawValue? = nil,
        price: PriceEnum.RawValue? = nil,
        headerImage: String? = nil,
        author: String? = nil,
        createdAt: Date? = nil,
        updatedAt: Date? = nil,
        publishedDate: Date? = nil
    ) {
        self.id = id
        self.title = title
        self.slug = slug
        self.tags = tags
        self.description = description
        self.status = status
        self.price = price
        self.headerImage = headerImage
        self.author = author
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.publishedDate = publishedDate
    }
    
    init(status: StatusEnum.RawValue) {
        self.status = status
    }
}

extension GuideModel: Content {}
