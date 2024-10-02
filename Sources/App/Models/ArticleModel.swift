//
//  File.swift
//  RESTAPI
//
//  Created by 赵康 on 2024/9/28.
//

import Foundation
import Vapor
import Fluent

final class ArticleModel: Model, @unchecked Sendable {
    static let schema: String = SchemaEnum.articles.rawValue
    
    @ID(key: .id)
    var id: UUID?
    
    @OptionalField(key: FieldKeys.title)
    var title: String?
    
    @OptionalField(key: FieldKeys.slug)
    var slug: String?
    
    @OptionalField(key: FieldKeys.excerpt)
    var excerpt: String?
    
    @OptionalField(key: FieldKeys.content)
    var content: String?
    
    @OptionalField(key: FieldKeys.guide)
    var guide: GuideModel.IDValue?
    
    @OptionalField(key: FieldKeys.headerImage)
    var headerImage: URL?
    
    @OptionalField(key: FieldKeys.author)
    var author: String?
    
    @OptionalField(key: FieldKeys.status)
    var status: StatusEnum.RawValue?
    
    @OptionalField(key: FieldKeys.price)
    var price: PriceEnum.RawValue?
    
    @OptionalField(key: FieldKeys.role)
    var role: ContentRoleEnum.RawValue?
    
    @Timestamp(key: FieldKeys.createdAt, on: .create)
    var createdAt: Date?
    
    @Timestamp(key: FieldKeys.updatedAt, on: .update)
    var updatedAt: Date?
    
    @OptionalField(key: FieldKeys.publishedDate)
    var publishedDate: Date?
    
    @OptionalField(key: FieldKeys.tags)
    var tags: [String]?
    
    init() {}
    init(id: UUID? = nil, title: String? = nil, slug: String? = nil, excerpt: String? = nil, content: String? = nil, guide: GuideModel.IDValue? = nil, headerImage: URL? = nil, author: String? = nil, status: StatusEnum.RawValue? = nil, price: PriceEnum.RawValue? = nil, role: ContentRoleEnum.RawValue? = nil, createdAt: Date? = nil, updatedAt: Date? = nil, publishedAt: Date? = nil, tags: [String]? = nil) {
        self.id = id
        self.title = title
        self.slug = slug
        self.excerpt = excerpt
        self.content = content
        self.guide = guide
        self.headerImage = headerImage
        self.author = author
        self.status = status
        self.price = price
        self.role = role
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.publishedDate = publishedDate
        self.tags = tags
    }
    
}

extension ArticleModel: Content {}
