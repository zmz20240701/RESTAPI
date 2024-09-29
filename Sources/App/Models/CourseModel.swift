//
//  File.swift
//  RESTAPI
//
//  Created by 赵康 on 2024/9/28.
//

import Foundation
import Vapor
import Fluent

final class CourseModel: Model, @unchecked Sendable {
    static let schema: String = SchemaEnum.courses.rawValue
    
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
    
    @OptionalField(key: FieldKeys.headerIamge)
    var headerImage: URL?
    
    @OptionalField(key: FieldKeys.article)
    var article: String?
    
    @OptionalField(key: FieldKeys.topHexColor)
    var topHexColor: String?
    
    @OptionalField(key: FieldKeys.bottomHexColor)
    var bottomHexColor: String?
    
    @OptionalField(key: FieldKeys.sylabus)
    var sylabus: URL?
    
    @OptionalField(key: FieldKeys.assets)
    var assets: URL?
    
    @OptionalField(key: FieldKeys.author)
    var author: String?
    
    @Timestamp(key: FieldKeys.createdAt, on: .create)
    var createAt: Date?
    
    @Timestamp(key: FieldKeys.updatedAt, on: .update)
    var updateAt: Date?
    
    @OptionalField(key: FieldKeys.publishedDate)
    var publishedDate: Date?
    
    init() {}
    
    init(id: UUID? = nil, title: String? = nil, slug: String? = nil, tags: [String]? = nil, description: String? = nil, status: StatusEnum.RawValue? = nil, price: PriceEnum.RawValue? = nil, headerImage: URL? = nil, article: String? = nil, topHexColor: String? = nil, bottomHexColor: String? = nil, sylabus: URL? = nil, assets: URL? = nil, author: String? = nil, createAt: Date? = nil, updateAt: Date? = nil, publishedDate: Date? = nil) {
        self.id = id
        self.title = title
        self.slug = slug
        self.tags = tags
        self.description = description
        self.status = status
        self.price = price
        self.headerImage = headerImage
        self.article = article
        self.topHexColor = topHexColor
        self.bottomHexColor = bottomHexColor
        self.sylabus = sylabus
        self.assets = assets
        self.author = author
        self.createAt = createAt
        self.updateAt = updateAt
        self.publishedDate = publishedDate
    }
    
    init(status: StatusEnum.RawValue) {
        self.status = status
    }
}

extension CourseModel: Content {}
